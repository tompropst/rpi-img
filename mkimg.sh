#!/bin/bash

if [ -z $1 ]; then
	echo "Must provide a disk path as the first argument"
	exit 1
fi

if [ -z $2 ]; then
	echo "Must provide an output file path as the second argument"
	exit 1
fi

DISK=$1
FILE=$2

if [ ! -b "$DISK" ]; then
	echo "Invalid disk path: $DISK"
	exit 1
fi

if [ -a "$FILE" ]; then
	echo "Output file already exists: $FILE"
	exit 1
fi

# Search for this in the fdisk output to get sector size.
# May not be portable.
SECTOR_STRING="Sector size (logical/physical):"
SIZE=$(sudo fdisk -l $DISK | grep "$SECTOR_STRING" | awk '{print $4}')
COUNT=$(sudo fdisk -l $DISK | tail -n 1 | awk '{print $3}')

sudo dd if=$DISK of=$FILE bs=$SIZE count=$COUNT status=progress
