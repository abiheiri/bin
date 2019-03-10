#!/bin/bash

rsync -va --delete ~/Dropbox/ /Volumes/Elements/share/backups/abiheiri/Dropbox/

rsync -va --delete "/Users/abiheiri/Library/Mobile Documents/com~apple~CloudDocs/Notes/" /Volumes/Elements/share/backups/abiheiri/Notes/

if [ $HOSTNAME = "WORD" ];
then
	echo "Add stuff here todo"
	#sync photos
	#sync music
	#sync audio production
fi
