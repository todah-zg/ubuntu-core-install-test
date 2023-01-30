#!/bin/bash

# install the dependencies
echo Installing dependencies... 

sudo apt install -y ubuntu-image snapd snapcraft ovmf

# Create the image
echo Creating the image

sudo ubuntu-image snap my-ubuntu-22-core.model

# Run the image in QEMU
echo Running the image using QEMU

sudo qemu-system-x86_64 -smp 2 -m 2048 \
 -net nic,model=virtio -net user,hostfwd=tcp::8022-:22 \
 -drive file=/usr/share/OVMF/OVMF_CODE.fd,if=pflash,format=raw,unit=0,readonly=on \
 -drive file=pc.img,cache=none,format=raw,id=disk1,if=none \
 -device virtio-blk-pci,drive=disk1,bootindex=1 -machine accel=kvm

# Optional: Create a bootable USB image
# Warning: be careful to use the correct device for your USB as all data will be wiped
# uncomment the following lines and edit the device name to use.

#USB_DEV=/dev/sdX
#sudo umount $USB_DEV
#sudo dd if=pc.img of=$USB_DEV bs=32M
