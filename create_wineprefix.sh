#!/bin/sh

# Skip if wineprefix is already created
if [ -d "/home/ubuntu/wineprefix/dosdevices" ]; then
    echo "Wineprefix already exist"
    exit
fi

# Create wineprefix
wineboot -u

# Apply winetricks to load libraries
winetricks --self-update
winetricks -f -q vcrun2022
winetricks -f -q corefonts
winetricks -f -q allcodecs
winetricks -f -q physx
winetricks -f -q dxvk
winetricks -f -q dxvk_nvapi0061
winetricks -f -q vkd3d



