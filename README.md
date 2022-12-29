# nmap AppImage

## Intro
This is a self-contained package of nmap, ncat, and nping, built in Ubuntu 16.04

I made this so it could be uploaded/used easily on compromised hosts (in CTF/similar of course)

Releases are automatic and happen each month, if a new nmap version was released

nmap is a complety separate project not handled by me, found at https://nmap.org . This project only covers the AppImage packaging

## Syntax
Different syntaxes are available :
```
nmap.AppImage <nmap options> # run as nmap
nmap.AppImage <tool name> <tool options> # run as the specified tool
nmap.AppImage lsexec # list available tools

mv nmap.AppImage <tool> && ./tool # run as the specified tool
```

Examples :
```
./nmap.AppImage localhost -A # makes a full scan of localhost
./nmap.AppImage ncat localhost 8080 # connects to localhost port 8080
./nmap.AppImage nping localhost -p 8080 # check port 8080 on localhost

# Opens port 8080
ln -s ncat nmap.AppImage
./ncat -lvp 8080
```
Note : if the environnment you are in doesn't have fuse, you may need to add the flag `--appimage-extract-and-run`

## Screenshots
![nmap scan](https://raw.githubusercontent.com/iTrooz/nmap-appimage/main/meta/nmap_scan.png)
![ncat open port](https://raw.githubusercontent.com/iTrooz/nmap-appimage/main/meta/ncat_open_port.png)

## Build from source
Simply run the [build.sh](https://github.com/iTrooz/nmap-appimage/blob/main/build.sh) script. You can take a look at the [CI workflow](https://github.com/iTrooz/nmap-appimage/blob/main/.github/workflows/main.yml) for more information, such as dependencies

## How ?
Launching multiple executables from the same AppImage is possible thanks to a modified AppRun , which was inspired by https://www.skepticats.com/rox/wrappers.html#template

You can find a more generic modified version at https://gist.github.com/iTrooz/f287a48b95d672c3c97fea4f12a40891


## Licence
The licence only apply to my work (build.sh, github actions workflow, etc...).

The nmap logo ([nmap.png](nmap.png) here) and any other nmap intellectual property are covered by the Nmap project (https://nmap.org/)
