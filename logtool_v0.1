#! /system/bin/sh
# Remix OS Log Tool v0.1 - only to /sdcard/RemixOS_Logs
# Must run as root
# Run using: sh /path/to/logtool_v0.1.sh
print '\n\tRemix OS Log Tool v0.1\n\n\tSaving logs please wait...\n'

#SET VARS FOR LOGFILE NAMING in format: <LOGTYPE>_BOOT-COMPLETE_<DEVICE MODEL>_<REMIX VERSION>_<REMIX ARCH>_<DATE>.TXT
model=$(getprop ro.product.model)
version=$(getprop ro.build.remixos.version)
system_arch=$(getprop ro.product.cpu.abi)
logcat="logcat_booted-userdumped_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
dmesg="dmesg_booted-userdumped_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
lspci="lspci_booted-userdumped_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
lsusb="lsusb_booted-userdumped_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
cpuinfo="cpuinfo_booted-userdumped_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"

# ACTUAL DUMPING
# SAVING TO INTERNAL REMIX STORAGE
logs_path="/storage/emulated/0/RemixOS_Logs/Usergenerated"
mkdir -p $logs_path
dmesg >  $logs_path/$dmesg
lspci > $logs_path/$lspci 
logcat -d > $logs_path/$logcat
lsusb > $logs_path/$lsusb
cat /proc/cpuinfo > $logs_path/$cpuinfo

print "\tDone. Few logs files were saved with names like:\n\t$dmesg\n\n\tYou can find the logs in RemixOS_Logs/Usergenerated directory in:\n\n\t1. Internal Storage - Remix OS path: $logs_path\n\tCheck 'My Remix'(/storage/emulated/0) tab in the File Manager app to find the given path.\n\n\tIf you have feedback for us, be sure to visit our Remix-OS-For-PC GitHub repository and use the new logs there.\n\tRemix-OS-For-PC GitHub repository: https://goo.gl/ulxY75\n"
