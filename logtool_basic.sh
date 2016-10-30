#!/system/bin/sh
# Remix OS Log Tool Basic v0.3 - only to /sdcard/RemixOS_Logs
# Must run as root
# Run using: sh /path/to/logtool_basic.sh
print '\n\tRemix OS Log Tool Basic v0.3\n\n\tSaving logs please wait...\n'

# Get system info for log naming
brand=$(getprop ro.product.manufacturer) && brand=${brand// /-}
model=$(getprop ro.product.model) && model=${model// /-}
version=$(getprop ro.build.remixos.version) && version=${version// /-}
system_arch=$(getprop ro.product.cpu.abi) && system_arch=${system_arch// /-}
# Log naming
logcat="logcat_BOOT-COMPLETE_${brand}_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
dmesg="dmesg_BOOT-COMPLETE_${brand}_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
lspci="lspci_BOOT-COMPLETE_${brand}_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
lsusb="lsusb_BOOT-COMPLETE_${brand}_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"
cpuinfo="cpuinfo_BOOT-COMPLETE_${brand}_${model}_${version}_${system_arch}_$(date +%F_%H-%M).txt"

# SAVING TO INTERNAL REMIX STORAGE
logs_path="/storage/emulated/0/RemixOS_Logs/Usergenerated/${brand}_${model}"
mkdir -p $logs_path
# ACTUAL DUMPING
dmesg >  $logs_path/$dmesg
lspci > $logs_path/$lspci 
logcat -d > $logs_path/$logcat
lsusb > $logs_path/$lsusb
cat /proc/cpuinfo > $logs_path/$cpuinfo

print "\tDone. Few log files were saved with names like:\n\t$dmesg\n\n\tYou can find the logs in RemixOS_Logs/Usergenerated/${brand}_${model} directory on:\n\n\t1. Internal Storage - Remix OS full path: $logs_path\n\tCheck 'My Remix'(/storage/emulated/0) tab in the File Manager app to find the given path.\n\n\tIf you have feedback for us, be sure to visit our Remix-OS-For-PC GitHub repository and use the new logs there.\n\tRemix-OS-For-PC GitHub repository: https://goo.gl/ulxY75\n"
