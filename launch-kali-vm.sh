#!/bin/bash

# A script for launching Kali Linux VM from terminal, preferably as an SSH connection.
# Utilizes qemu (a ready-to-use hard disk image can be downloaded from https://www.kali.org/get-kali/#kali-virtual-machines)

DISK_IMAGE=drive_file.qcow2
UI=false
DISPLAY_OPTION=""
ASCII_ART=ascii_art.txt
USER=user
DELAY="0.2s"

ps -ef | grep -q -P qemu-system-x86_64.+file=$DISK_IMAGE
if [ $? == 0 ]; then
  VM_ALREADY_RUNNING=true
else
  VM_ALREADY_RUNNING=false
fi


for arg in "$@"; do
  if [ "$arg" == "-ui" ]; then
    UI=true
  fi
done

if [ $UI == "false" ]; then
  DISPLAY_OPTION="-display none"
fi
if [ $VM_ALREADY_RUNNING == "false" ]; then
  qemu-system-x86_64 \
    -enable-kvm \
    -m 4096 \
    -cpu host \
    -smp 4 \
    -drive file=$DISK_IMAGE \
    -nic user,model=virtio,hostfwd=tcp::2222-:22 \
    -display gtk,zoom-to-fit=on \
    -boot c \
    $DISPLAY_OPTION &
fi

if [ $UI == "false" ] && [ $VM_ALREADY_RUNNING == "false" ]; then
	echo "Starting kali. Please wait..."

	cat $ASCII_ART | while IFS= read -r line; do
	    echo "$line"
	    sleep "$DELAY"
	done

	ssh -p 2222 $USER@localhost
fi

if [ $VM_ALREADY_RUNNING == "true" ]; then
  echo "kali already running, establishing SSH connection..."
	ssh -p 2222 $USER@localhost
fi
