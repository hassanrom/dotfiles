To disable trackpad
-------------------

```
$ xinput list
⎡ Virtual core pointer                      id=2  [master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer                id=4  [slave  pointer  (2)]
⎜   ↳ TPPS/2 IBM TrackPoint                     id=13 [slave  pointer  (2)]
⎜   ↳ SynPS/2 Synaptics TouchPad                id=11 [slave  pointer  (2)]
⎣ Virtual core keyboard                     id=3  [master keyboard (2)]
    ↳ Virtual core XTEST keyboard               id=5  [slave  keyboard (3)]
    ↳ Power Button                              id=6  [slave  keyboard (3)]
    ↳ Video Bus                                 id=7  [slave  keyboard (3)]
    ↳ Sleep Button                              id=8  [slave  keyboard (3)]
    ↳ AT Translated Set 2 keyboard              id=10 [slave  keyboard (3)]
    ↳ ThinkPad Extra Buttons                    id=12 [slave  keyboard (3)]
    ↳ Integrated Camera                         id=9  [slave  keyboard (3)]

$ xinput set-prop 11 "Device Enabled" 0
```

To compile your own i3 on ubuntu precise
----------------------------------------

1. Download latest i3 tarball from i3's website.
```
$ wget http://i3wm.org/downloads/i3-4.6.tar.bz2
```

2. Install dependencies.
```
$ sudo apt-get install libxcb1-dev libxcb-keysyms1-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-xinerama0-dev libpango1.0-dev libxcursor-dev
```

3. Compile & install.
```
$ make
$ sudo make install
```

To compile your own i3status on ubuntu precise
----------------------------------------------

1. Download latest i3status.
```
$ wget http://i3wm.org/i3status/i3status-2.8.tar.bz2
```

2. Install dependencies.
```
$ sudo apt-get install libasound2-dev libiw-dev libconfuse-dev
```

3. Compile & install.
```
$ make
$ sudo make install
```

To compile your own vim on ubuntu precise
-----------------------------------------

I mostly followed the instructions on
[this](https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source)
page but I removed gui support & enabled lua.

```
$ sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev ruby-dev mercurial lua5.2 liblua5.2-0 liblua5.2-dev libx11-dev libxtst-dev
$ sudo apt-get remove vim vim-runtime gvim vim-tiny vim-common vim-gui-common
$ cd
$ hg clone https://code.google.com/p/vim/
$ cd vim
$ ./configure --with-features=huge --enable-rubyinterp --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7-config --enable-perlinterp --enable-cscope --prefix=/usr/local --enable-luainterp --with-x
$ make VIMRUNTIMEDIR=/usr/share/vim/vim74
$ sudo apt-get install checkinstall
$ sudo checkinstall
```

For some reason setting VIMRUNTIMEDIR to /usr/share/vim/vim74 while making
doesn't work. If that doesn't work for you, you may need to set VIMRUNTIMEDIR
environment variable to /usr/local/share/vim/vim74 in your zshrc.

To enable authentication via fingerprint
----------------------------------------

1. Install the packages
```
$ sudo add-apt-repository ppa:fingerprint/fingerprint-gui
$ sudo apt-get update
$ sudo apt-get install libbsapi policykit-1-fingerprint-gui fingerprint-gui
```

2. Setup.
```
$ fingerprint-gui
```

For more info [see](http://fcns.eu/2012/04/29/fingerprint-reader/).


To compile your own sakura binary
---------------------------------

1. Download latest sakura tarball from sakura's website.
```
$ wget https://launchpad.net/sakura/trunk/3.1.3/+download/sakura-3.1.3.tar.bz2
```

2. Install dependencies.
```
$ sudo apt-get install cmake libgtk-3-dev libvte-2.90-dev
```

3. Compile & install.
```
$ cmake -DCMAKE_INSTALL_PREFIX=/usr/local .
$ make
$ sudo make install
```
