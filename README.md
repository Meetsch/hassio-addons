# folder-rsync

## About this addon

This repository is forked from https://github.com/carstenschroeder/hassio-addons.

This simple addon transfers the Hass.io folders /addons, /backup, /config, /share, /ssl and /media to a remote rsync server (e.g. a Synology NAS). The addon transfers the changes to the destination at every start. After the transfer it stops.

## Installation

Adding this add-ons repository to your Hass.io Home Assistant instance is
pretty easy. Follow https://home-assistant.io/hassio/installing_third_party_addons/ on the
website of Home Assistant, and use the following URL:

```
https://github.com/LinusHoppe/hassio-addons/
```

## Configuration

You have to provide the following config parameters:

| option | type | description | example |
| ------------- | ------------- | ------------- | ------------- | 
| rsyncserver  | string  | rsync target server  | 192.168.0.1  |
| rootfolder  | string  | rsync folder, must exist on the target server  | hassio-sync  |
| username  | string  | rsync target server  | user  |
| password  | string  | rsync target server  | password  |
| rsyncoptions  | string  | options for rsync, please refer to https://wiki.ubuntuusers.de/rsync/ or https://linux.die.net/man/1/rsync for all options  | --no-perms -rltvh --delete  |
| syncconfig  | boolean  | sync /config  | true  |
| syncaddons  | boolean  | sync /addons  | true  |
| syncbackup  | boolean  | sync /backup  | true  |
| syncshare  | boolean  | sync /share  | true  |
| syncssl  | boolean  | sync /ssl  | true  |
| syncmedia  | boolean  | sync /media  | true  |

## Automation

You might want to start the transfer with a HASS automation
```
alias: Rsync to NAS
description: ''
trigger:
  - platform: time
    at: '02:00:00'
condition: []
action:
  - service: hassio.addon_start
    data:
      addon: 293a5356_folderrsync
mode: single
```
