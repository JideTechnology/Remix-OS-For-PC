#! /system/bin/sh
#SET VARS FOR LOGFILE NAMING in format: <LOGTYPE>_BOOT-COMPLETE_<DEVICE MODEL>_<REMIX VERSION>_<REMIX ARCH>_<DATE>.TXT
model=$(getprop ro.product.model)
version=$(getprop ro.build.remixos.version)
system_arch=$(getprop ro.product.cpu.abi)
logcat="logcat_boot-complete_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
dmesg="dmesg_boot-complete_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
lspci="lspci_boot-complete_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
lsusb="lsusb_boot-complete_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
cpuinfo="cpuinfo_boot-complete_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
# WELCOME MESSAGE
print "\nRemix Log Dumper v0.6\n\nLogs will be dumped into 2 locations:\n\n1. /sdcard/RemixOS-logs - Remix File Manager has /sdcard named as My Remix.\n2. /RemixOS/RemixOS-logs - directory created on the storage medium RemixOS is installed on.\n\nDumping log files to /sdcard/RemixOS-logs, please wait...\n"
# ACTUAL DUMPING
# SAVING TO INTERNAL REMIX STORAGE
remix_sdcard_path="/sdcard/RemixOS-logs"
mkdir -p $remix_sdcard_path
dmesg >  $remix_sdcard_path/$dmesg
lspci > $remix_sdcard_path/$lspci 
logcat -d > $remix_sdcard_path/$logcat
lsusb > $remix_sdcard_path/$lsusb
cat /proc/cpuinfo > $remix_sdcard_path/$cpuinfo
### END OF DUMP
print "Dump to $remix_sdcard_path complete. Now will dump to Remix installation drive...\n"
#MOUNT NATIVE PARTITION IF NEEDED AND THEN COPY LOGS FROM SDCARD
native_partition=$(cat /native_partition 2>/dev/null)
if  [[ $native_partition ]]; then
	native_partition_fstype=$(blkid -s TYPE -o value $native_partition)
	if [[ $native_partition_fstype = "ntfs" ]]; then
		ntfs_mountpoint="/mnt/native_partition"
		mkdir -p $ntfs_mountpoint
		ntfs-3g $native_partition $ntfs_mountpoint 2>/dev/null
		#if partition really accessible then copy dumps 
		if [[ $(ls $ntfs_mountpoint 2>/dev/null) ]]; then
			ntfs_path="$ntfs_mountpoint/RemixOS/RemixOS-logs"
			mkdir -p $ntfs_path
			cp $remix_sdcard_path/$dmesg $ntfs_path $remix_sdcard_path/$lspci $ntfs_path $remix_sdcard_path/$logcat $ntfs_path $remix_sdcard_path/$lsusb $ntfs_path $remix_sdcard_path/$cpuinfo $ntfs_path 2>/dev/null
		fi
		# CODE FOR SCENARIO WHEN NATIVE PARTITION IS NOT NTFS
		else 
			print "Not NTFS\n"
	fi
fi
print "Dump is complete.\nIf you have problems with Remix use these logs at https://goo.gl/oQSsz6\nYou can attach those logs to your GitHub issue. That's all :)"
