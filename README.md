# Raspberry Pi Image Tools

## Manual Steps To Be Automated

* Enable SSH
	- Add `ssh` file to `/boot/`
* Add `wpa_supplicant.conf` for your wireless networks
	- Add `wpa_supplicant.conf` to `/boot/`
* Disable expansion of the disk image on first boot (can be done explicitely later if desired)
	- Remove `init` argument from `/boot/cmdline.txt`

### After Boot

* Copy authorized keys to for the `pi` user account
* Set locale
	- `sudo raspi-config`
	- Generate the locale (and remove GB from the generation list if desired)
	- Select it
* Set Timezone
* Enable SPI
* Enable I2C

## Image Creation

* Creates small image of an existing disk
* `./mkimg.sh <disk> <file>`

## Disk Creation

* Copies an image to a disk
* `./mkdisk.sh <file> <disk>`

