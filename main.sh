#!/bin/bash

git checkout kernel-main

# Apply OEM modifications
echo "Applying OEM modifications"
git reset HEAD^

DIFFPATHS=(
    "Documentation/"
    "android/"
    "arch/arm/boot/dts/"
    "arch/arm64/boot/dts/"
    "arch/arm/configs/"
    "arch/arm64/configs/"
    "arch/"
    "block/"
    "crypto/"
    "drivers/android/"
    "drivers/base/"
    "drivers/block/"
    "drivers/media/platform/msm/"
    "drivers/char/"
    "drivers/clk/"
    "drivers/cpufreq/"
    "drivers/cpuidle/"
    "drivers/gpu/drm/"
    "drivers/gpu/"
    "drivers/input/touchscreen/"
    "drivers/input/touchscreen/Xiaomi"
    "drivers/input/"
    "drivers/leds/"
    "drivers/misc/"
    "drivers/mmc/"
    "drivers/nfc/"
    "drivers/power/"
    "drivers/scsi/"
    "drivers/soc/"
    "drivers/thermal/"
    "drivers/usb/"
    "drivers/video/"
    "drivers/"
    "firmware/"
    "fs/"
    "include/"
    "init/"
    "kernel/"
    "lib/"
    "mm/"
    "net/"
    "security/"
    "sound/"
    "techpack/audio/"
    "techpack/camera/"
    "techpack/display/"
    "techpack/dataipa/"
    "techpack/stub/"
    "techpack/video/"
    "techpack/"
    "tools/"
)
for ELEMENT in ${DIFFPATHS[@]}; do
    [[ -d $ELEMENT ]] && git add $ELEMENT > /dev/null 2>&1
    git -c "user.name=Laulan56" -c "user.email=stevexian56@gmail.com" commit -sm "$ELEMENT: Import OEM changes" > /dev/null 2>&1
done
# Remaining OEM modifications
git add --all > /dev/null 2>&1
git -c "user.name=Laulan56" -c "user.email=stevexian56@gmail.com" commit -sm "Import remaining OEM modifications" > /dev/null 2>&1
