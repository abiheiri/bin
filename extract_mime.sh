#!/usr/bin/env bash
#20150429 - Al Biheiri - #ZD101612

note () {
	cat <<EOF
	This script will extract the MIME messages so that you can feed them to spamassassin.
	It will NOT mess with your spamassassin or mail server for that matter. It will only
	mess with the files in the dir that holds the MIME messages. Please have a handy backup
	of the MIME messages before you begin. mmmk bye


	Usage $0 /path/to/emails [spam|ham]

	examples:
       	$0 /tmp/safe_folder ham
	$0 /tmp/spam_folder spam
EOF
}

pre () {
	grep "spam parse completed" /tmp/$0_result.txt > /dev/null 2>&1
	if [[ $? = 0 ]]; then
		echo "You already ran this program. I suspect you dont know what you are doing."
		exit 7
	fi
}

post () {
	echo "spam parse completed" >> /tmp/$0_result.txt
	cat <<EOF
	The files were properly extracted. Now you can feed the data using below steps on an smtp server

		sa-learn --nosync --spam /folderpath
		sa-learn --nosync --ham /folderpath
		sa-learn --sync
EOF
}

if [[ -d "$1" ]]; then
	case $2 in
		spam)
			pre
			find $1 -type f -exec sed -i -r -n -e '/Content-Disposition: inline/,${p}' {} \;
			post
			exit
			;;
		ham)
			find $1 -type f -exec sed -i -r -n -e '/Content-Disposition: inline/,${p}' {} \;
			post
			echo "not implemented yet"
			exit
			;;
		*)
			echo "it looks like you dont know what you are doing or you fat fingered a key."
			exit 8
			;;
	esac
else
	note
fi


