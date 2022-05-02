# hassio-addons

## About

forked from https://github.com/carstenschroeder/hassio-addons

## Installation

Adding this add-ons repository to your Hass.io Home Assistant instance is
pretty easy. Follow https://home-assistant.io/hassio/installing_third_party_addons/ on the
website of Home Assistant, and use the following URL:

```
https://github.com/LinusHoppe/hassio-addons/
```

## Add-ons provided by this repository

### [folder-rsync]

This simple addon transfers the Hass.io folders /addons, /backup, /config, /share, /ssl and /media to a remote rsync server (e.g. a Synology NAS).
The addon transfers the changes to the destination at every start. After the transfer it stops.

You might want to start the transfer with a HASS automation
```
- id: '7'
  alias: Folder sync to NAS
  trigger:
    platform: time
    at: '1:00:00'
  action:
  - service: hassio.addon_start
    data:
      addon: 954f2f4e_folderrsync
```
