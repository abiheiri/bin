#!/bin/bash

EXTERNAL="/Volumes/Elements"

rsync -va --delete "$HOME/Dropbox/" "$EXTERNAL/share/backups/abiheiri/Dropbox/"
rsync -va --delete "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Notes/" $EXTERNAL/share/backups/abiheiri/Notes/
rsync -va --delete "$HOME/Dropbox/music production/" "$EXTERNAL/share/backups/audio-projects/music production/"

#Dont delete remove data
rsync -va "$HOME/Pictures/AutoImport/" "$EXTERNAL/share/backups/backup-pics-videos/AutoImport/"
