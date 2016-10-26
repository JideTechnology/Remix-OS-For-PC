#! /system/bin/sh
# Remix OS Log Tool v0.3
# Prerequisites: 
# - modified initrd.img (with custom init script - https://goo.gl/N5kXvV )
# - running as root ex. sh /path/to/logtool_v0.3.sh
# Function: Saves dmesg,logcat,lspci,lsusb,cpuinfo to 3 locations: 
# - /storage/emulated/0/RemixOS_Logs/Usergenerated
# - X:/$native_partition_remix_dir/RemixOS_Logs/Usergenerated 
# - REMIX_OS:/RemixOS_Logs/Usergenerated - if booted from USB

# Remove below comment to see any errors, the script may produce, in the terminal
# set -x
source /boot_info

print '\n\tRemix OS Log Tool v0.3\n\n\tSaving logs please wait...\n'

# Log naming
model=$(getprop ro.product.model)
version=$(getprop ro.build.remixos.version)
system_arch=$(getprop ro.product.cpu.abi)
logcat="logcat_boot-complete_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
dmesg="dmesg_boot-complete_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
lspci="lspci_boot-complete_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
lsusb="lsusb_boot-complete_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
cpuinfo="cpuinfo_boot-complete_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"

# ACTUAL DUMPING
logs_src="RemixOS_Logs/Usergenerated"
logs_sdcard="/storage/emulated/0/$logs_src" && mkdir -p $logs_sdcard
dmesg >  $logs_sdcard/$dmesg
lspci > $logs_sdcard/$lspci 
logcat -d > $logs_sdcard/$logcat
lsusb > $logs_sdcard/$lsusb
cat /proc/cpuinfo > $logs_sdcard/$cpuinfo

if [[ -n "$native_partition_path" ]]; then
	native_partition_mountpoint=$(mount | grep /mnt/media_rw/$native_partition_uuid | awk '{print $3}')
fi
if [[ -n "$usb_boot_win_partition_path" ]]; then
	usb_boot_win_partition_mountpoint=$(mount | grep /mnt/media_rw/$usb_boot_win_partition_uuid | awk '{print $3}')
fi
# Make sure logs are copied onto native partition (specially important for Windows users)
if  [[ -n "$native_partition_mountpoint" ]]; then
	logs_native="$native_partition_mountpoint/$native_partition_remix_dir/$logs_src"
	mkdir -p $logs_native
	cp $logs_sdcard/$dmesg $logs_native $logs_sdcard/$lspci $logs_native $logs_sdcard/$logcat $logs_native $logs_sdcard/$lsusb $logs_native $logs_sdcard/$cpuinfo $logs_native 2>/dev/null
	else 
		mkdir -p /mnt/media_rw/$native_partition_uuid
		ntfs-3g $native_partition_path /mnt/media_rw/$native_partition_uuid 2>/dev/null
		mount $native_partition_path /mnt/media_rw/$native_partition_uuid 2>/dev/null
		logs_native="/mnt/media_rw/$native_partition_uuid/$native_partition_remix_dir/$logs_src"
		mkdir -p $logs_native
		cp $logs_sdcard/$dmesg $logs_native $logs_sdcard/$lspci $logs_native $logs_sdcard/$logcat $logs_native $logs_sdcard/$lsusb $logs_native $logs_sdcard/$cpuinfo $logs_native 2>/dev/null
fi
# If booted from usb, make sure logs are copied to the REMIX_OS partition - windows friendly.
if [[ -n "$usb_boot_win_partition_path" ]]; then
	if [[ -n "$usb_boot_win_partition_mountpoint" ]]; then
		logs_usb_win="$usb_boot_win_partition_mountpoint/$logs_src"
		mkdir -p $logs_usb_win
		cp $logs_sdcard/$dmesg $logs_usb_win $logs_sdcard/$lspci $logs_usb_win $logs_sdcard/$logcat $logs_usb_win $logs_sdcard/$lsusb $logs_usb_win $logs_sdcard/$cpuinfo $logs_usb_win 2>/dev/null
		else 
			mkdir -p /mnt/media_rw/$usb_boot_win_partition_uuid
			ntfs-3g $usb_boot_win_partition_path /mnt/media_rw/$usb_boot_win_partition_uuid 2>/dev/null
			mount $usb_boot_win_partition_path /mnt/media_rw/$usb_boot_win_partition_uuid 2>/dev/null
			logs_usb_win="/mnt/media_rw/$usb_boot_win_partition_uuid/$logs_src"
			mkdir -p $logs_usb_win
			cp $logs_sdcard/$dmesg $logs_usb_win $logs_sdcard/$lspci $logs_usb_win $logs_sdcard/$logcat $logs_usb_win $logs_sdcard/$lsusb $logs_usb_win $logs_sdcard/$cpuinfo $logs_usb_win 2>/dev/null
	fi
fi

print "\tDone. Few logs files were saved with names like:\n\t$dmesg\n\n\tYou can find the logs in $logs_src directory in few locations:\n\n\t1. Internal Storage - Remix OS path: $logs_sdcard\n\tCheck 'My Remix'(/storage/emulated/0) tab in the File Manager app to find the given path.\t"
if [[ "$DATA_IN_MEM" -eq 1 ]]; then
	print "\tWARNING!!! Currently system runs in GUEST mode - logs saved to this location will be lost upon restart."
fi
print "\n\t2. Remix OS installation folder - Remix OS path: $logs_native\n\tLook for the logs on the disk on which you installed Remix OS."
if [[ -n "$usb_boot_win_partition_path" ]]; then
	print "\n\t3. Windows friendly USB partition - Windows path: REMIX_OS:/$logs_src"
fi

print "\n\tIf you have feedback for us, be sure to visit our Remix-OS-For-PC GitHub repository and use the new logs there.\n\tRemix-OS-For-PC GitHub repository: https://psuedolink.com\n"
