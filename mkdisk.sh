#!/bin/bash

if [ -z $1 ]; then
	echo "Must provide an image file path as the first argument"
	exit 1
fi

if [ -z $2 ]; then
	echo "Must provide a disk path as the second argument"
	exit 1
fi

FILE=$1
DISK=$2

if [ ! -b "$DISK" ]; then
	echo "Invalid disk path: $DISK"
	exit 1
fi

if [ ! -e "$FILE" ]; then
	echo "Invalid file path: $FILE"
	exit 1
fi

DISK_BYTES=$(sudo fdisk -l $DISK | head -n 1 | awk '{print $5}')
if [ $(($DISK_BYTES / 2**30)) -gt 16 ]; then
	echo "That is a large, $(($DISK_BYTES / 2**30))GB disk."
	read -n1 -p "Are you sure it is the one you want to overwrite? [y/N] " yN
	echo
	if [ "$yN" != "y" ]; then
		exit 1
	fi
fi

echo "About to overrite the contents of $DISK with $FILE."
read -n1 -p "Continue? [y/N] " yN
echo
if [ "$yN" != "y" ]; then
	exit 1
fi

# oflag=sync is optional but provides a more accurate transfer progress
sudo dd of=$DISK if=$FILE bs=4M oflag=sync status=progress

