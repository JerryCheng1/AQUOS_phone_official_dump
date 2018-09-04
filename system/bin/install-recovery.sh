#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/platform/soc.0/7824900.sdhci/by-name/recovery:14904620:2af4c8718e01f4010827475c4e78d65b9007534c; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/soc.0/7824900.sdhci/by-name/boot:10937640:95f9a5f31c449bb2a0ac04e006288f000f509867 EMMC:/dev/block/platform/soc.0/7824900.sdhci/by-name/recovery 2af4c8718e01f4010827475c4e78d65b9007534c 14904620 95f9a5f31c449bb2a0ac04e006288f000f509867:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
