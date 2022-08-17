# nmap AppImage

This is a self-contained package of nmap, ncat, and nping

I made this so it could be uploaded/used easily on compromised hosts (in CTF/similar of course)

Releases are automatic and happen each month, if a new nmap version was released

Different syntaxes are available :
```
nmap.AppImage <nmap options> # launhes as nmap
nmap.AppImage <tool name> <tool options> # launches as the specified tool
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


Launching multiple executables from the same AppImage is possible thanks to a modified AppRun , which was inspired by https://www.skepticats.com/rox/wrappers.html#template

You can find a more generic modified version at https://gist.github.com/iTrooz/f287a48b95d672c3c97fea4f12a40891