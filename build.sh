#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### Customization service
# Apply permissions
chmod 755 /usr/bin/personalize-config

# Install personalisation systemd service
ln -s /usr/lib/systemd/user/personalize-config.service /usr/lib/systemd/user/default.target.wants/personalize-config.service

### Personalization
# Remove the boot splash 'aurora' watermark
rm /usr/share/plymouth/themes/spinner/watermark.png

# set the sddm greeter background
ln -sf /usr/share/backgrounds/personalized-aurora/sticky_piston.png /usr/share/backgrounds/default.png
ln -sf /usr/share/backgrounds/personalized-aurora/sticky_piston.png /usr/share/backgrounds/default-dark.png

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

#### Systemd services