#!/bin/sh

NMAP_SVN="https://svn.nmap.org/nmap-releases/"
DIR=$(dirname $(realpath $0))

NMAP_VER_FOLDER=`svn ls $NMAP_SVN | tail -n 1`
NMAP_VER=${NMAP_VER_FOLDER%/}
NMAP_VER=${NMAP_VER#nmap-}
echo "-- nmap version is $NMAP_VER"
echo $NMAP_VER > $DIR/NMAP_VERSION

if [ "$1" != "--nodl" ]; then

    echo "--- Preparing linuxdeploy..."
    curl https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage -o linuxdeploy -L
    chmod +x linuxdeploy

    echo "--- Cloning latest version of nmap..."
    svn checkout $NMAP_SVN/$NMAP_VER_FOLDER $DIR/nmap
fi

echo "--- Build nmap..."
rm -rf $DIR/AppDir
cd $DIR/nmap
./configure --with-nmap --with-ncat --with-nping --without-ndiff --without-zenmap --prefix /usr
make install -j 4 DESTDIR=$DIR/AppDir || exit

mkdir -p $DIR/AppDir/usr/share/metainfo
cp $DIR/nmap.metainfo.xml $DIR/AppDir/usr/share/metainfo
ln -s nmap.metainfo.xml $DIR/AppDir/usr/share/metainfo/nmap.appdata.xml 

echo "--- Packaging AppImage..."
cd $DIR
export VERSION=$NMAP_VER
export UPDATE_INFORMATION="gh-releases-zsync|iTrooz|nmap-appimage|latest|nmap-*.AppImage.zsync"
./linuxdeploy --appimage-extract-and-run --appdir AppDir -d nmap.desktop -i nmap.png --custom-apprun AppRun --output appimage
