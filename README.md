# Build charm from Source

Copyright (c) 2016-2018 University of California, Irvine. All rights reserved.

Authors: Seyed Mohammadjavad Seyed Talebi and Hamid Tavakoli, UC Irvine; Hang Zhang and Zheng Zhang, UC Riverside; Ardalan Amiri Sani, UC Irvine; Zhiyun Qian, UC Riverside 

This document is shared under the GNU Free Documentation License WITHOUT ANY WARRANTY. See https://www.gnu.org/licenses/ for details.
_____________________________

Charm facilitates dynamic analysis of device drivers of mobile systems. This document is a toturial to build Charm on Linux. 

Please refer to our paper for technical details: [USENIX paper](http://www.ics.uci.edu/~ardalan/papers)

## Prerequisites

It is strongly recommended to backup your system before proceeding.

### Hardware


### Software

## Charm organizaiton

Charm system consists of five main components:
- Phone OS (Lineage OS Android for Bullhead)
- Android emulator 
- Host OS (Ubuntu)
- Syzkaller
- VM OS (AOSP Android for goldfish)

In following section we show how to build these components from source.
**Note: Please use our exact Naming convention for  files and directories.
**
first make a directory for Charm project  and cd to it.
```bash
mkdir Charm && cd Charm
```
then make a directory for each component of Charm.
```bash
mkdir bullhead_lineage
mkdir goldfish_AOSP
mkdir Android_emulator
mkdir Host_Ubuntu
mkdir Syzkaller
```
_____________________________

### build Phone OS
#### Download source code
Follow the documention for building Lineage OS (version cm-14.1) for bullhead, from [here](http://https://wiki.lineageos.org/devices/bullhead/build "here").
Note: you need to change these two lines of the documentation:

~~cd ~/android/lineage
repo init -u https://github.com/LineageOS/android.git -b lineage-15.1~~  
Instead use:
```bash
cd Charm/bullhead_lineage
repo init -u https://github.com/LineageOS/android.git -b cm-14.1
```
Note: It might take a few hours to finish.
#### Apply changes
Considering you are in `Charm/bullhead_lineage/` directory, In order to apply our changes, perform following steps:
```bash
cd kernel/lge/bullhead
git fetch https://github.com/trusslab/charm_bullhead_kernel.git
git checkout Charm
```
go back to `Charm/bullhead_lineage/`, then:
```bash
cd system/core
git fetch https://github.com/trusslab/charm_bullhead_core.git
git checkout Charm
```
go back to `Charm/bullhead_lineage/`, then:
```bash
cd frameworks/native
git fetch https://github.com/trusslab/charm_bullhead_native.git
git checkout Charm
```
#### Build
To build the system go back to `Charm/bullhead_lineage/`, and run:
```bash
  source ./build/envsetup.sh
   brunch lineage_bullhead-eng
```
#### Install on the Phone
After build proccess finshes you need to Install the Android on your phone.  Connect your Nexus5x Phone to your system and run:
```bash
adb reboot recovery
```
In recovery menu please select `adb-sideload`. 
Assuming you are in `Charm/bullhead_lineage/`you can reach the OUT directory where all built images are, using:
```bash
cd out/target/product/bullhead 
```
You can find the LineageOS installer package under the name `lineage-14.1-[DATE]-UNOFFICIAL-bullhead.zip` (in which [DATE] is replaced with date of your build). To install the package on your phone:
```bash
adb sideload  lineage-14.1-[DATE]-UNOFFICIAL-bullhead.zip
```
_____________________________
 ### build Android emulator
 #### Download source code
downlaod the source for android emulator from Google. Assume you are in `Charm/` directory:
```bash
cd Android_emulator
repo init -u https://android.googlesource.com/platform/manifest -b emu-2.4-release
repo sync
```
#### Apply changes
then you need to apply Charm changes to the QEMU. 
```bash
cd external/qemu
git fetch  https://github.com/trusslab/charm_emulator.git 
git checkout Charm
```
#### Build
in order to build the emulator:
```bash
./android/rebuild.sh
```
Note: the expected output should look like this:
```console
Configuring build.
Building sources.
Checking for 'emulator' launcher program.
Checking that 'emulator' is a 64-bit program.
Running 64-bit unit test suite.
   - android_emu64_unittests
   - emugl64_common_host_unittests
   - emulator64_libui_unittests
   - emulator64_crashreport_unittests
   - lib64OpenglRender_unittests
   - lib64GLcommon_unittests
Running emugen_unittests.
Running emugen regression test suite.
Running gen-entries.py test suite.
ERROR: Unit test failures:  android_emu64_unittests
```
_____________________________

### build Host OS
 #### Download source code
download the operating systme for the host. 
```bash
cd Host_Ubuntu
git clone https://github.com/trusslab/charm_host_kernel.git -b Charm
```
#### Build
build the ubuntu using build script.
```bash
cd charm_host_kernel
source build.sh
```
Note: It might take a few hours to finish.

after instalation finishes go back one directory to `Charm/Host_Ubuntu/ `
to install the built Ubuntu on your system:
```bash
sudo dpkg -i linux-*4.10.0-28.32*.deb
```
#### Update the Grub
???
You need to reboot your machine and boot the new Ubuntu.





