#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### Personalization service
## Service that will automatcally apply the personalized configuration to the user one

# Apply permissions
chmod 755 /usr/bin/personalize-config


### End personalization service

### Personalization
# Remove the boot splash 'aurora' watermark
rm /usr/share/plymouth/themes/spinner/watermark.png

# set the sddm greeter background
ln -sf /usr/share/backgrounds/personalized-aurora/sticky_piston.png /usr/share/backgrounds/default.png
ln -sf /usr/share/backgrounds/personalized-aurora/sticky_piston.png /usr/share/backgrounds/default-dark.png

sed -i 's|^background=.*|background=/usr/share/backgrounds/default.png|' /usr/share/sddm/themes/breeze/theme.conf


# Set utilities-terminal icon instead of the ptyxis icon
sed -i 's/Icon=org.gnome.Ptyxis/Icon=utilities-terminal/' /usr/share/applications/org.gnome.Ptyxis.desktop

# Link to the setup desktop in the skel desktop folder so that a new user will run it
ln -s /usr/share/applications/personalized-aurora-setup.desktop /etc/skel/Desktop/personalized-aurora-setup.desktop

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