#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

# Apply script permissions
chmod 755 /usr/bin/personalize-config
chmod 755 /usr/bin/personalize-system

# Sound theme
rpm-ostree install oxygen-sounds

# set the sddm greeter background
ln -sf /usr/share/backgrounds/personalized-aurora/sticky_piston.png /usr/share/backgrounds/default.png
ln -sf /usr/share/backgrounds/personalized-aurora/sticky_piston.png /usr/share/backgrounds/default-dark.png

sed -i 's|^background=.*|background=/usr/share/backgrounds/default.png|' /usr/share/sddm/themes/breeze/theme.conf

# Set the default breeze lookandfeel wallpaper
ln -sf /usr/share/backgrounds/personalized-aurora/sticky_piston.png /usr/share/wallpapers/personal-aurora.png
kwriteconfig5 --file /usr/share/plasma/look-and-feel/org.kde.breezedark.desktop/contents/defaults --group Wallpaper --key Image personal-aurora

# Replace ptyxis icon with utilities-terminal that fits better into plasma
sed -i 's/Icon=org.gnome.Ptyxis/Icon=utilities-terminal/' /usr/share/applications/org.gnome.Ptyxis.desktop

# Link to the setup desktop in the skel desktop folder so that a new user will run it
mkdir -p /etc/skel/Desktop
ln -s /usr/share/applications/personalized-aurora-setup.desktop /etc/skel/Desktop/personalized-aurora-setup.desktop