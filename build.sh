#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

# Apply script permissions
chmod 755 /usr/bin/personalize-config
chmod 755 /usr/bin/personalize-system

# Sound theme
rpm-ostree install oxygen-sounds

# SDDM background
sed -i 's|^background=.*|background=/usr/share/backgrounds/default.png|' /usr/share/sddm/themes/breeze/theme.conf

# Replace ptyxis icon with utilities-terminal that fits better into plasma
sed -i 's/Icon=org.gnome.Ptyxis/Icon=utilities-terminal/' /usr/share/applications/org.gnome.Ptyxis.desktop
