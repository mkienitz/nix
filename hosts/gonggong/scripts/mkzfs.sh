set -e
zpool create -R /mnt -o ashift=12 \
  -O acltype=posix \
  -O atime=off \
  -O xattr=sa \
  -O dnodesize=auto \
  -O mountpoint=none \
  -O canmount=noauto \
  -O devices=off \
  -O compression=zstd \
  rpool /dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_36659119-part2

zfs create -o mountpoint=/ rpool/root
zfs create -o mountpoint=/home/max rpool/home
