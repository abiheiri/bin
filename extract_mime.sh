#!/usr/bin/env bash
#20150429 - Al Biheiri - #ZD101612

note () {
	cat <<EOF
	This script will extract the MIME messages so that you can feed them to spamassassin.

	Usage $0 /path/to/emails [spam|ham]

	examples:
       	$0 /tmp/safe_folder ham
	$0 /tmp/spam_folder spam
EOF
}

post () {
	cat <<EOF
	Now you can feed the data using below steps on an smtp server

		sa-learn --nosync --spam $1
		sa-learn --nosync --ham $1
		sa-learn --sync
EOF
}

if [[ -d "$1" ]]; then
	case $2 in
		spam)
			find $1 -type f -exec sed -i -r -n -e '/Content-Disposition: inline/,${p}' {} \;
			post
			;;
		ham)
			echo "not implemented yet"
			;;
	esac
else
	note
fi


