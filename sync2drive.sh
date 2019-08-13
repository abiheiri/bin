#!/bin/bash

EXTERNAL="/Volumes/SSD"

rsync -va --delete "$HOME/Dropbox/" "$EXTERNAL/share/backups/abiheiri/Dropbox/"
rsync -va --delete "$HOME/Dropbox/music production/" "$EXTERNAL/share/backups/audio-projects/music production/"
rsync -va --delete "$HOME/Documents/" "$EXTERNAL/share/backups/abiheiri/twofah docs/"

#Dont delete remove data
rsync -va "$HOME/Pictures/AutoImport/" "$EXTERNAL/share/backups/backup-pics-videos/AutoImport/"
