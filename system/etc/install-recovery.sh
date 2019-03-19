#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:27825386:0dbe5bd220aa1d0d43b7f598cc9c2754cafb077d; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/bootdevice/by-name/boot:26576102:0becda4cfb492fcaf57c03fd7c140995a9235e82 EMMC:/dev/block/bootdevice/by-name/recovery 0dbe5bd220aa1d0d43b7f598cc9c2754cafb077d 27825386 0becda4cfb492fcaf57c03fd7c140995a9235e82:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
