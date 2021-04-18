#!/bin/bash

read -p "Tag you want your techpack to base on: " tag

# Apply Techpack changes
echo "Applying Techpack changes"
git branch kernel-main
git branch techpack-CAF
git checkout -b techpack-OEM
git reset HEAD^
DIFFPATHS=(
    "techpack/"
)
for ELEMENT in ${DIFFPATHS[@]}; do
    [[ -d $ELEMENT ]] && git add $ELEMENT > /dev/null 2>&1
    git -c "user.name=KernelCleanUP" -c "user.email=kernelcleaner@noone.com" commit -sm "$ELEMENT: OEM changes" > /dev/null 2>&1
done
git add .
git -c "user.name=KernelCleanUP" -c "user.email=kernelcleaner@noone.com" commit -sm "OTHER: OEM changes" > /dev/null 2>&1
git reset --hard HEAD^

echo "Applying Techpack changes from CAF,it may takes long time..."
git checkout techpack-CAF
git reset --hard HEAD^
# Import CAF's techpack
git remote add audio-kernel http://source.codeaurora.cn/quic/la/platform/vendor/opensource/audio-kernel/
git remote add camera-kernel http://source.codeaurora.cn/quic/la/platform/vendor/opensource/camera-kernel/
git remote add dataipa http://source.codeaurora.cn/quic/la/platform/vendor/opensource/dataipa/
git remote add display-drivers http://source.codeaurora.cn/quic/la/platform/vendor/opensource/display-drivers/
git remote add video-driver http://source.codeaurora.cn/quic/la/platform/vendor/opensource/video-driver/

git subtree add --prefix=techpack/audio audio-kernel $tag
git subtree add --prefix=techpack/camera camera-kernel $tag
git subtree add --prefix=techpack/dataipa dataipa $tag
git subtree add --prefix=techpack/display display-drivers $tag
git subtree add --prefix=techpack/video video-driver $tag

git checkout kernel-main

# Apply OEM modifications
echo "Applying OEM modifications"
git reset HEAD^

# Delete old techpack
rm -rf /techpack

# Import CAF's techpack
git remote add audio-kernel http://source.codeaurora.cn/quic/la/platform/vendor/opensource/audio-kernel/
git remote add camera-kernel http://source.codeaurora.cn/quic/la/platform/vendor/opensource/camera-kernel/
git remote add dataipa http://source.codeaurora.cn/quic/la/platform/vendor/opensource/dataipa/
git remote add display-drivers http://source.codeaurora.cn/quic/la/platform/vendor/opensource/display-drivers/
git remote add video-driver http://source.codeaurora.cn/quic/la/platform/vendor/opensource/video-driver/

git subtree add --prefix=techpack/audio audio-kernel $tag
git subtree add --prefix=techpack/camera camera-kernel $tag
git subtree add --prefix=techpack/dataipa dataipa $tag
git subtree add --prefix=techpack/display display-drivers $tag
git subtree add --prefix=techpack/video video-driver $tag

git diff techpack-OEM techpack-CAF | git apply --reject

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
    git -c "user.name=KernelCleanUP" -c "user.email=kernelcleaner@noone.com" commit -sm "$ELEMENT: Import OEM changes" > /dev/null 2>&1
done
# Remaining OEM modifications
git add --all > /dev/null 2>&1
git -c "user.name=KernelCleanUP" -c "user.email=kernelcleaner@noone.com" commit -sm "Import remaining OEM modifications" > /dev/null 2>&1
