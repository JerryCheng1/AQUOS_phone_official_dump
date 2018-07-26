#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery:9142272:aa3bbe5d0faa7982036411cf44bbc6b69ad3f362; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/msm_sdcc.1/by-name/boot:8163328:5f21489b2b6b7a032f88b9eb7af50c34759ec2cc EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery aa3bbe5d0faa7982036411cf44bbc6b69ad3f362 9142272 5f21489b2b6b7a032f88b9eb7af50c34759ec2cc:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
