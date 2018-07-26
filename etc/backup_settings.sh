#!/system/bin/sh

SRC_DIR="/data/data"
DST_DIR="/durable/settingsDB"

COPY_OBJS=( "com.android.providers.settings/databases"
            "jp.co.sharp.android.providers.settingsex/databases"
            "com.android.settings/shared_prefs"
          )

# clean old files
[ -d ${DST_DIR} ] && rm -rf ${DST_DIR}

for COPY_OBJ in "${COPY_OBJS[@]}"; do
    mkdir -p ${DST_DIR}/${COPY_OBJ}
    cp -rf ${SRC_DIR}/${COPY_OBJ} ${DST_DIR}/${COPY_OBJ}/..
done

