#!/bin/bash

EXTERNAL="/Volumes/SSD"

rsync -va --delete "$HOME/Dropbox/" "$EXTERNAL/share/backups/abiheiri/Dropbox/"
rsync -va --delete "$HOME/Dropbox/music production/" "$EXTERNAL/share/backups/audio-projects/music production/"

if [ $(hostname) = "Als-MacBook.local" ];
then
	rsync -va --delete "$HOME/Documents/" "$EXTERNAL/share/backups/abiheiri/twofah docs/"
fi

#Dont delete remove data
rsync -va "$HOME/Pictures/AutoImport/" "$EXTERNAL/share/backups/backup-pics-videos/AutoImport/"
