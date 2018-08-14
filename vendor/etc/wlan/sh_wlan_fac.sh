#!/system/bin/sh

WcnssMacAddrFile=$(ls /sys/bus/platform/devices/*wcnss-wlan/wcnss_mac_addr 2>/dev/null)
stat $WcnssMacAddrFile >/dev/null 2>&1
if [ $? -eq 0 ]
then
  stat /sys/module/sh_wlan_fac/parameters/wlanmac_from_smem >/dev/null 2>&1
  if [ $? -eq 0 ]
  then
    MacAddress=$(cat /sys/module/sh_wlan_fac/parameters/wlanmac_from_smem 2>/dev/null)
    log -p i -t ShWlanFac "got MAC address: $MacAddress"
    log -p i -t ShWlanFac "WcnssMacAddrFile: $WcnssMacAddrFile"
    echo "$MacAddress" > $WcnssMacAddrFile 2>/dev/null
  else
    log -p e -t ShWlanFac "/sys/module/sh_wlan_fac/parameters/wlanmac_from_smem not exist"
  fi
else
  log -p e -t ShWlanFac "WcnssMacAddrFile not exist: ${WcnssMacAddrFile}"
fi

TxLevel=M
stat /sys/module/sh_wlan_fac/parameters/nv_tx_level >/dev/null 2>&1
if [ $? -eq 0 ]
then
  TxLevel=$(cat /sys/module/sh_wlan_fac/parameters/nv_tx_level 2>/dev/null)
  log -p i -t ShWlanFac "got NV TX Level: $TxLevel"

  if [ "$TxLevel" != "H" -a "$TxLevel" != "M" -a "$TxLevel" != "L" ]
  then
    log -p e -t ShWlanFac "NV TX Level is not valid, set to default(M)"
    TxLevel=M
  fi
else
  log -p e -t ShWlanFac "/sys/module/sh_wlan_fac/parameters/nv_tx_level not exist"
fi

SrcFile=/vendor/etc/wlan/WCNSS_qcom_wlan_nv_${TxLevel}.bin
stat $SrcFile >/dev/null 2>&1
if [ $? -ne 0 ]
then
  log -p e -t ShWlanFac "Source NV file not exist: $SrcFile"
  exit $?
fi

DstFile=/persist/WCNSS_qcom_wlan_nv.bin
stat $DstFile >/dev/null 2>&1
if [ $? -ne 0 ]
then
  log -p e -t ShWlanFac "Destination NV file not exist: $DstFile"
  exit $?
fi

log -p i -t ShWlanFac "Comparing $SrcFile and $DstFile"
cmp $SrcFile $DstFile >/dev/null 2>&1
if [ $? -ne 0 ]
then
  log -p i -t ShWlanFac "The src/dst NV files differ. Copying"
  cp $SrcFile $DstFile >/dev/null 2>&1
  log -p i -t ShWlanFac "Copy NV file completed"
else
  log -p i -t ShWlanFac "The src/dst NV files are the same. Not copy"
fi

exit $?
