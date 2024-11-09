#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### Apply permissions
chmod 755 /usr/bin/personalize-config

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

#### Systemd services