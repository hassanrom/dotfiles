# More info can be found here:
# http://linuxconfig.org/usb-stick-encryption-using-linux

if [ "$OS" = "Linux" ]; then
  function usb_mount() {
    # TODO: Don't hardcode /dev/sdb2. Figure out a better way to do this.
    sudo cryptsetup luksOpen /dev/sdb2 private
    sudo mount /dev/mapper/private /mnt/private
  }

  function usb_umount() {
    sudo umount /mnt/private
    sudo cryptsetup luksClose /dev/mapper/private
  }
fi
