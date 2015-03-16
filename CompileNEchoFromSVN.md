## Prerequisites ##

### devkitARM ###

Ok, first things first.  You need devkitARM/devkitPro to be able to compile this.  You can follow the instructions on the wiki:

http://wiki.devkitpro.org/index.php/Getting_Started

For Ubuntu users/Linux users in general, this version is more concise:

http://blog.dev-scene.com/ndsgr/devkitarm-in-ubuntu-edgy/

For Unix (Linux, Mac) in general:

http://www.coderjoe.net/archive/2007/07/23/setting-up-an-nds-homebrew-tool-chain-in-linux-and-mac-osx-ok-windows-too/

### Get **make** ###

For those who don't know, GNU make is a utility/programming language for compilation.  Because I absolutely don't know how to make VC++/XCode compilation files, I'm just supporting makefiles.

For Windows:

http://unxutils.sourceforge.net/

For Mac, I think you need to get XCode:

http://developer.apple.com/tools/gcc_overview.html

For Linux...you know where it is.

### Get the code from SVN ###

All set?  You also need to get an SVN client to download the source code:

http://code.google.com/p/l-echo/source/checkout

I never really use any SVN client other for commits, so don't ask me.

## Compiling ##

1) At the l-echo folder: `make setup-nds`

2) Enter the n-echo folder, and: `make`