#!/system/bin/sh
# Remix OS Log Tool Basic v0.4 by Vioner
# Thanks a lot to Mohamed for thoroughly testing with me! I owe you moman2000 ! (XDA Forum user)
#
# Prerequisites:
# - running as root

# Features:
# 1. Lognames include essential environment info
# 2. Saves logs: dmesg,logcat,lspci,lsmod,lsusb,cpuinfo to internal storage (/sdcard):

# Usage: https://goo.gl/bsZcsq - use logtool_basic.sh instead of logtool.sh

# Remove below comment to see script running line-by-line, command-by-command in terminal
# set -x

print '\n\tRemix OS Log Tool Basic v0.4\n\n\tSaving logs please wait...\n'

# Get system info for log naming
brand=$(getprop ro.product.manufacturer) && brand=${brand// /-}
model=$(getprop ro.product.model) && model=${model// /-}
version=$(getprop ro.build.remixos.version) && version=${version// /-}
system_arch=$(getprop ro.product.cpu.abi) && system_arch=${system_arch// /-}
# Log naming
pattern="BOOT-COMPLETE_${brand}_${model}_${version}-${system_arch}_$(date +%F_%H-%M).txt"
logcat="logcat_${pattern}"
dmesg="dmesg_${pattern}"
lsmod="lsmod_${pattern}"
lspci="lspci_${pattern}"
lsusb="lsusb_${pattern}"
cpuinfo="cpuinfo_${pattern}"

# SAVING TO INTERNAL REMIX STORAGE
logs_path="/storage/emulated/0/RemixOS_Logs/Usergenerated/${brand}_${model}"
mkdir -p $logs_path
# ACTUAL DUMPING
dmesg > $logs_path/$dmesg
lsmod > $logs_path/$lsmod
lspci > $logs_path/$lspci
logcat -d > $logs_path/$logcat
lsusb > $logs_path/$lsusb
cat /proc/cpuinfo > $logs_path/$cpuinfo

print "\tDone. Few logs files were saved with names like:\n\t$dmesg\n\n\tYou can find the logs in ${brand}_${model} directory in location:\n\n\t1. Internal Storage - Remix OS full path:\n\t${logs_path}\n\tCheck 'My Remix'(/storage/emulated/0) tab in the File Manager app to find the given path.\n\n\tIf you have feedback for us, be sure to visit our Remix-OS-For-PC GitHub repository and use the new logs there.\n\tRemix-OS-For-PC GitHub repository: https://goo.gl/ulxY75\n"
exit 0
