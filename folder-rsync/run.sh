#!/bin/bash
set -e

echo "[Info] Starting Hass.io folder rsync docker container!"

CONFIG_PATH=/data/options.json
rsyncserver=$(jq --raw-output ".rsyncserver" $CONFIG_PATH)
rootfolder=$(jq --raw-output ".rootfolder" $CONFIG_PATH)
username=$(jq --raw-output ".username" $CONFIG_PATH)
password=$(jq --raw-output ".password" $CONFIG_PATH)
rsyncoptions=$(jq --raw-output ".rsyncoptions" $CONFIG_PATH)

syncconfig=$(jq --raw-output ".syncconfig" $CONFIG_PATH)
syncaddons=$(jq --raw-output ".syncaddons" $CONFIG_PATH)
syncbackup=$(jq --raw-output ".syncbackup" $CONFIG_PATH)
syncshare=$(jq --raw-output ".syncshare" $CONFIG_PATH)
syncssl=$(jq --raw-output ".syncssl" $CONFIG_PATH)
syncmedia=$(jq --raw-output ".syncmedia" $CONFIG_PATH)

rsyncurl="$username@$rsyncserver::$rootfolder"

echo "[Info] trying to rsync hassio folders to $rsyncurl using rsync options $rsyncoptions"
echo ""

if [ "$syncconfig" == "true" ]
then
	echo "[Info] sync /homeassistant"
	echo ""
	sshpass -p $password rsync $rsyncoptions --exclude '*.db-shm' --exclude '*.db-wal' /config/ $rsyncurl/homeassistant/ 
fi

if [ "$syncaddons" == "true" ]
then
	echo "[Info] sync /addon_configs"
	echo ""
	sshpass -p $password rsync $rsyncoptions /addon_configs/ $rsyncurl/addon_configs/ 
fi

if [ "$syncbackup" == "true" ]
then
	echo "[Info] sync /backup"
	echo ""
	sshpass -p $password rsync $rsyncoptions /backup/ $rsyncurl/backup/ 
fi

if [ "$syncshare" == "true" ]
then
	echo "[Info] sync /share"
	echo ""
	sshpass -p $password rsync $rsyncoptions /share/ $rsyncurl/share/ 
fi

if [ "$syncssl" == "true" ]
then
	echo "[Info] sync /ssl"
	echo ""
	sshpass -p $password rsync $rsyncoptions /ssl/ $rsyncurl/ssl/ 
fi

if [ "$syncmedia" == "true" ]
then
	if [ -d "/media" ]; then
	 echo ""
	 echo "[Info] sync /media"
	 sshpass -p $password rsync $rsyncoptions /media/ $rsyncurl/media/
	else 
	 echo ""
	 echo "[Info] /media not existing"
	fi
fi

echo "[Info] Finished rsync"
