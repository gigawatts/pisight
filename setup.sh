#!/bin/bash

# 1. Enable camera and serial interfaces: sudo raspi-config
# 2. Run this script: sudo ./setup.sh

set -e

cd /home/pi

sudo apt-get install -y git
git clone https://github.com/maxbbraun/uvc-gadget
cd uvc-gadget

make

sudo cp piwebcam.service /etc/systemd/system/
sudo systemctl enable piwebcam

sudo sed -i 's/^console=\(.*\)$/\1 modules-load=dwc2,libcomposite/' /boot/cmdline.txt

sudo printf "\ndtoverlay=dwc2" >> /boot/config.txt

sudo ln -s /lib/systemd/system/getty@.service /etc/systemd/system/getty.target.wants/getty@ttyGS0.service
