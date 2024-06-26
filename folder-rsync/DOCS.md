# folder-rsync Documentation

## Installation

Adding this add-ons repository to your Hass.io Home Assistant instance is
pretty easy. Follow https://home-assistant.io/hassio/installing_third_party_addons/ on the
website of Home Assistant, and use the following URL:

```
https://github.com/Meetsch/hassio-addons/
```

### Install Troubleshooting

When using Home Assistant Supervisor install can fail because of missing internet connection for the supervisor.

To fix the issues you must use a static IP address and use public DNS:

Settings > Hardware > Network

* Static IP (not DHCP)

* DNS: ```8.8.8.8, 8.8.4.4, 1.1.1.1, 1.0.0.1```

## Configuration

You have to provide the following config parameters:

| option | type | description | example |
| ------------- | ------------- | ------------- | ------------- | 
| rsyncserver  | string  | rsync target server address  | 192.168.0.1  |
| rootfolder  | string  | rsync folder, must exist on the target server  | Backup/hassio  |
| username  | string  | rsync target server login  | hass-rsync  |
| password  | string  | rsync target server login password  | password  |
| rsyncoptions  | string  | options for rsync, please refer to https://wiki.ubuntuusers.de/rsync/ or https://linux.die.net/man/1/rsync for all options  | --no-perms -rltvh --delete  |
| syncconfig  | boolean  | sync /homeassistant  | true  |
| syncaddons  | boolean  | sync /addon_configs  | true  |
| syncbackup  | boolean  | sync /backup  | true  |
| syncshare  | boolean  | sync /share  | true  |
| syncssl  | boolean  | sync /ssl  | true  |
| syncmedia  | boolean  | sync /media  | true  |

Example yaml configuration:

```
rsyncserver: 192.168.0.1
rootfolder: Backup/hassio
username: hass-rsync
password: password
rsyncoptions: '--no-perms -rltvh --delete'
syncconfig: true
syncaddons: true
syncbackup: true
syncshare: true
syncssl: true
syncmedia: true
```

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
      addon: 66be7df6-hassio-folderrsync
mode: single
```
