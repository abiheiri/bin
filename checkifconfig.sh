
#if you plug external usb nic and have ip matching 64.84 then turn off wifi connection
#i created this because i dont want my wifi running at work while my ethernet is running

ifconfig en0 | grep inet > /dev/null 2>&1
iswifioff=$?

if [[ $iswifioff = 1 ]]; then
	exit
fi



ifconfig en4 |grep 64.84 > /dev/null 2>&1
extnic=$?

if [[ $extnic  == 0 ]]; then
	networksetup -setairportpower airport off > /dev/null 2>&1
fi
