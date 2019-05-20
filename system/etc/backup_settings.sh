#!/system/bin/sh

SRC_DIR_DE="/data/user_de/0"
SRC_DIR_SYS="/data/system/user/0"
DST_DIR="/durable/settingsDB"

COPY_OBJS_DE=( "com.android.providers.settings/databases"
               "jp.co.sharp.android.providers.settingsex/databases"
               "com.android.settings/shared_prefs" )

COPY_OBJS_SYS=( "settings_system.xml" "settings_global.xml" "settings_secure.xml" )

# clean old files
[ -d ${DST_DIR} ] && rm -rf ${DST_DIR}

for COPY_OBJ in "${COPY_OBJS_DE[@]}"; do
    mkdir -p ${DST_DIR}/${COPY_OBJ}
    cp -rf ${SRC_DIR_DE}/${COPY_OBJ} ${DST_DIR}/${COPY_OBJ}/..
done

for COPY_OBJ in "${COPY_OBJS_SYS[@]}"; do
    mkdir -p ${DST_DIR}/${COPY_OBJ}
    cp -rf ${SRC_DIR_SYS}/${COPY_OBJ} ${DST_DIR}/${COPY_OBJ}/..
done

