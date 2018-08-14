#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/platform/soc.0/7824900.sdhci/by-name/recovery:14904620:e4283b060e84b25a303127b78fc1e15a6b960198; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/soc.0/7824900.sdhci/by-name/boot:10937640:cf41d31644a4c208a0a7cf5263c6d6c1cf797709 EMMC:/dev/block/platform/soc.0/7824900.sdhci/by-name/recovery e4283b060e84b25a303127b78fc1e15a6b960198 14904620 cf41d31644a4c208a0a7cf5263c6d6c1cf797709:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
