DEVICE_ID=01829e0915a692e9
EMULATOR=/home/$USER/Charm/Android_emulator/external/qemu/objs/emulator
KERNEL='/home/'$USER'/Charm/goldfish_AOSP/charm_emulator_kernel/arch/x86/boot/bzImage'
SYSTEM='/home/'$USER'/Charm/goldfish_AOSP/system.img'
RAMDISK='/home/'$USER'/Charm/goldfish_AOSP/ramdisk.img'
INITDATA='/home/'$USER'/Charm/goldfish_AOSP/userdata.img'
PORT_NUM=5560
MEMORY=1024
CORES=8
AVD=Nexus_5x_Charm
ENCRYOTION_PATH='/home/mj/Charm/goldfish_AOSP/encryptionkey.img'


dev_file="$(python find_dev_file.py $DEVICE_ID )"
echo  $dev_file

sudo ANDROID_SDK_ROOT=/home/mj/Android/Sdk  $EMULATOR -kernel $KERNEL -system $SYSTEM  -ramdisk $RAMDISK -initdata $INITDATA -avd $AVD -port $PORT_NUM -memory $MEMORY -cores $CORES -encryption-key $ENCRYOTION_PATH -gpu off -accel on -no-window  -debug init -show-kernel  -wipe-data -charm-usb-dev-file "$dev_file"
