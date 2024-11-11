# Remove the boot splash 'aurora' watermark
rm /usr/share/plymouth/themes/spinner/watermark.png

### Update initramfs
## Required for the removed boot splash image to update
## code from https://github.com/ublue-os/bluefin/blob/f833e1f6a5d1863b26e6f24a5ec28068d511b3de/build_files/base/19-initramfs.sh


# Swap for surface kernel
#KERNEL_SUFFIX="surface"
KERNEL_SUFFIX=""

QUALIFIED_KERNEL="$(rpm -qa | grep -P 'kernel-(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | sed -E 's/kernel-(|'"$KERNEL_SUFFIX"'-)//')"
/usr/libexec/rpm-ostree/wrapped/dracut --no-hostonly --kver "$QUALIFIED_KERNEL" --reproducible -v --add ostree -f "/lib/modules/$QUALIFIED_KERNEL/initramfs.img"
chmod 0600 "/lib/modules/$QUALIFIED_KERNEL/initramfs.img"

### End update initramfs