# Custom key mappings.
xmodmap ~/.Xmodmap

# Disable touchpad.
# TODO: For some reason, this doesn't get executed on start up or if it does it
# doesn't work. I just went ahead and disable the touchpad in bios settings
# instead.
xinput set-prop 11 "Device Enabled" 0
