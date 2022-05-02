#!/bin/bash
set -e

echo "[Info] Starting Hass.io folder rsync docker container!"

CONFIG_PATH=/data/options.json
rsyncserver=$(jq --raw-output ".rsyncserver" $CONFIG_PATH)
rootfolder=$(jq --raw-output ".rootfolder" $CONFIG_PATH)
username=$(jq --raw-output ".username" $CONFIG_PATH)
password=$(jq --raw-output ".password" $CONFIG_PATH)

rsyncurl="$username@$rsyncserver::$rootfolder"

echo "[Info] trying to rsync hassio folders to $rsyncurl"
echo ""
echo "[Info] sync /config"
sshpass -p $password rsync --no-perms -rltvh --delete --exclude '*.db-shm' --exclude '*.db-wal' /config/ $rsyncurl/config/ 
echo ""
echo "[Info] sync /addons"
sshpass -p $password rsync --no-perms -rltvh --delete /addons/ $rsyncurl/addons/ 
echo ""
echo "[Info] sync /backup"
sshpass -p $password rsync --no-perms -rltvh --delete /backup/ $rsyncurl/backup/ 
echo ""
echo "[Info] sync /share"
sshpass -p $password rsync --no-perms -rltvh --delete /share/ $rsyncurl/share/ 
echo ""
echo "[Info] sync /ssl"
sshpass -p $password rsync --no-perms -rltvh --delete /ssl/ $rsyncurl/ssl/ 
if [ -d "/media" ]; then
 echo ""
 echo "[Info] sync /media"
 sshpass -p $password rsync --no-perms -rltvh --delete /media/ $rsyncurl/media/
else 
 echo ""
 echo "[Info] /media not existing"
fi

echo "[Info] Finished rsync"