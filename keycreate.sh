#!/usr/bin/env bash


if [[ $1 == "" ]]; then
	echo "Please provide a hostname"
	exit 1
else
	HOSTNAME=$1	
fi


echo -n Enter a password:
read -s password
echo


echo $password | kadmin -q "addprinc -randkey host/$HOSTNAME.stanford.edu@CS.STANFORD.EDU"
echo $password | kadmin -q "ktadd -k /var/tmp/$HOSTNAME.Stanford.EDU.keytab host/$HOSTNAME.stanford.edu@CS.STANFORD.EDU"

scp /var/tmp/$HOSTNAME.Stanford.EDU.keytab root@$HOSTNAME:/etc/krb5.keytab
cp /var/tmp/$HOSTNAME.Stanford.EDU.keytab /afs/.cs/etc/krb5.keytabs/

sleep 5
rv /afs/.cs/etc/krb5.keytabs/




