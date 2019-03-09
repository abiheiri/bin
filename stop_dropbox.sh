#
# This is to make sure I am not running Dropbox at work 
#

#capture wifi SSID
SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')

#case insensitive activation
shopt -s nocasematch

REGEX="^(apple)*"
#REGEX="^(alNHR)*"

if [[ $SSID =~ $REGEX ]];
  then 
   osascript -e 'tell application "Dropbox" to quit'
fi

