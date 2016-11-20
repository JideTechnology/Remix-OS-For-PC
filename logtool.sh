#!/system/bin/sh
# Remix OS Log Tool v0.42 by Vioner
# Thanks a lot to Mohamed for thoroughly testing with me! I owe you moman2000 ! (XDA Forum user)
#
# Prerequisites:
# - modified initrd.img (with custom init script - https://goo.gl/DSkjXT )
# - running as root ex. sh /path/to/logtool.sh
#
# Features:
# Saves dmesg,logcat,lspci,lsusb,cpuinfo to 3 locations:
# - /storage/emulated/0/RemixOS_Logs/Usergenerated
# - X:/$native_partition_remix_dir/RemixOS_Logs/Usergenerated
# - REMIX_OS:/RemixOS_Logs/Usergenerated - if booted from removable media

# Remove below comment to see script running line-by-line, command-by-command in terminal
# set -x

mkdir -p /storage/emulated/0/RemixOS_Logs
# Comment below line to set error output into terminal
exec 2> /storage/emulated/0/RemixOS_Logs/Logtool_errors.log
source /boot_info

print '\n\tRemix OS Log Tool v0.42\n\n\tSaving logs please wait...\n'

# Log naming
brand=$(getprop ro.product.manufacturer) && brand=${brand// /-}
model=$(getprop ro.product.model) && model=${model// /-}
version=$(getprop ro.build.remixos.version) && version=${version// /-}
system_arch=$(getprop ro.product.cpu.abi) && system_arch=${system_arch// /-}
logcat="logcat_BOOT-COMPLETE_${brand}_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
dmesg="dmesg_BOOT-COMPLETE_${brand}_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
lsmod="lsmod_BOOT-COMPLETE_${brand}_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
lspci="lspci_BOOT-COMPLETE_${brand}_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
lsusb="lsusb_BOOT-COMPLETE_${brand}_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
cpuinfo="cpuinfo_BOOT-COMPLETE_${brand}_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"

# Set logs location for Internal Storage
logs_src="RemixOS_Logs/Usergenerated/${brand}_${model}"
logs_sdcard="/storage/emulated/0/$logs_src" && mkdir -p $logs_sdcard

# Dump the logs
dmesg > $logs_sdcard/$dmesg
lsmod > $logs_path/$lsmod
lspci > $logs_sdcard/$lspci
logcat -d > $logs_sdcard/$logcat
lsusb > $logs_sdcard/$lsusb
cat /proc/cpuinfo > $logs_sdcard/$cpuinfo

if [[ -n "$native_partition_path" ]]; then
	native_partition_mountpoint=$(mount | grep /mnt/media_rw/$native_partition_uuid | awk '{print $3}')
fi
if [[ -n "$removable_boot_win_partition_path" ]]; then
	removable_boot_win_partition_mountpoint=$(mount | grep /mnt/media_rw/$removable_boot_win_partition_uuid | awk '{print $3}')
fi
# Make sure logs are copied onto native partition (specially important for Windows users)
if  [[ -n "$native_partition_mountpoint" ]]; then
	logs_native="$native_partition_mountpoint/$native_partition_remix_dir/$logs_src"
	mkdir -p $logs_native
	cp $logs_sdcard/$lsmod $logs_native $logs_sdcard/$dmesg $logs_native $logs_sdcard/$lspci $logs_native $logs_sdcard/$logcat $logs_native $logs_sdcard/$lsusb $logs_native $logs_sdcard/$cpuinfo $logs_native
else
	mkdir -p /mnt/media_rw/$native_partition_uuid
	ntfs-3g $native_partition_path /mnt/media_rw/$native_partition_uuid
	mount $native_partition_path /mnt/media_rw/$native_partition_uuid
	logs_native="/mnt/media_rw/$native_partition_uuid/$native_partition_remix_dir/$logs_src"
	mkdir -p $logs_native
	cp $logs_sdcard/$lsmod $logs_native $logs_sdcard/$dmesg $logs_native $logs_sdcard/$lspci $logs_native $logs_sdcard/$logcat $logs_native $logs_sdcard/$lsusb $logs_native $logs_sdcard/$cpuinfo $logs_native
fi
# If booted from removable media make sure logs are copied to the REMIX_OS partition - Windows friendly.
if [[ -n "$removable_boot_win_partition_path" ]]; then
	if [[ -n "$removable_boot_win_partition_mountpoint" ]]; then
		logs_removable_win="$removable_boot_win_partition_mountpoint/$logs_src"
		mkdir -p $logs_removable_win
		cp $logs_sdcard/$lsmod $logs_removable_win $logs_sdcard/$dmesg $logs_removable_win $logs_sdcard/$lspci $logs_removable_win $logs_sdcard/$logcat $logs_removable_win $logs_sdcard/$lsusb $logs_removable_win $logs_sdcard/$cpuinfo $logs_removable_win
	else
		mkdir -p /mnt/media_rw/$removable_boot_win_partition_uuid
		ntfs-3g $removable_boot_win_partition_path /mnt/media_rw/$removable_boot_win_partition_uuid
		mount $removable_boot_win_partition_path /mnt/media_rw/$removable_boot_win_partition_uuid
		logs_removable_win="/mnt/media_rw/$removable_boot_win_partition_uuid/$logs_src"
		mkdir -p $logs_removable_win
		cp $logs_sdcard/$lsmod $logs_removable_win $logs_sdcard/$dmesg $logs_removable_win $logs_sdcard/$lspci $logs_removable_win $logs_sdcard/$logcat $logs_removable_win $logs_sdcard/$lsusb $logs_removable_win $logs_sdcard/$cpuinfo $logs_removable_win
	fi
fi

print "\tDone. Few logs files were saved with names like:\n\t$dmesg\n\n\tYou can find the logs in ${brand}_${model} directory in few locations:\n\n\t1. Internal Storage - Remix OS full path:\n\t$logs_sdcard\n\tCheck 'My Remix'(/storage/emulated/0) tab in the File Manager app to find the given path.\t"
if [[ "$DATA_IN_MEM" -eq 1 ]]; then
	print "\tWARNING!!! Currently system runs in GUEST mode - logs saved to this location will be lost upon restart."
fi
print "\n\t2. Remix OS installation folder - Remix OS full path:\n\t$logs_native\n\tLook for the logs on the disk on which you installed Remix OS."
if [[ -n "$removable_boot_win_partition_path" ]]; then
	print "\n\t3. Windows friendly partition - Windows path:\n\tREMIX_OS:/$logs_src"
fi

print "\n\tIf you have feedback for us, be sure to visit our Remix-OS-For-PC GitHub repository and use the new logs there.\n\tRemix-OS-For-PC GitHub repository: https://goo.gl/ulxY75\n"
