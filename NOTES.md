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
wget http://i3wm.org/downloads/i3-4.6.tar.bz2
```

2. Install dependencies.
```
sudo apt-get install libxcb1-dev libxcb-keysyms1-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-xinerama0-dev libpango1.0-dev libxcursor-dev
```

3. Compile & install.
```
$ make
$ sudo make install
```

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
