#!/system/bin/sh
umask 0177
if	cat /data/system/device_policies.xml > /dev/null 2>&1
then	log -t init_devadmin.sh "status = 0"
elif	cat /system/vendor/etc/device_policies.xml > /data/system/device_policies.xml 2> /dev/null
then	log -t init_devadmin.sh "status = 1"
else	log -t init_devadmin.sh "status = -1"
fi
