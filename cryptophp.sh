#!/bin/bash
## cryptophp For Cpanel by websouls.com

Email="support@websouls.com"

### Matching Hashes ###
for users in `ls /var/cpanel/users/* | cut -d / -f 5`; do
find -L /home/$users/public_html/ -type f -name 'social.png' > /tmp/cryptophp.txt

	if [[ -s "/tmp/cryptophp.txt" ]]; then
		for i in `cat /tmp/cryptophp.txt`; do
			hash=`md5sum $i | awk '{print $1}'`
			
				for x in `cat hashes.txt`; do
					
					if [[ $hash = $x ]]; then
					echo $i >> /tmp/cryptophp.hashes
					fi
				done
		done
	fi
done
if [[ -s "/tmp/cryptophp.hashes" ]]; then
	cat /tmp/cryptophp.hashes | mail -s "Hash Match Please Check File On Host:$HOSTNAME" $Email
fi


## Cpanel Use Backdoor ##
for emails in `cat emails.txt`; do
	grep $emails /var/log/exim_mainlog >> /tmp/cryptophp.cpaneluser
done
if [[ -s "/tmp/cryptophp.cpaneluser" ]]; then
	cat /tmp/cryptophp.cpaneluser | mail -s "Cpanel User Sending Emails To Backdoor Email On Host:$HOSTNAME" $Email
fi

## Black List Ip Used For Access ##
for ip in `cat ip.txt`; do
	grep -R "$ip" /usr/local/apache/domlogs/ | cut -d : -f 1,2,5 > /tmp/cryptophp.ip
done
if [[ -s "/tmp/cryptophp.ip" ]]; then
	cat /tmp/cryptophp.ip | mail -s "Domain Logs From Black List IP On Host:$HOSTNAME" $Email
fi

## Checking Black List Domains
for domains in `cut -d : -f 2 /etc/domainusers | sed -e "s/ //g"`; do
	for domains1 in `cat domains.txt`; do
		if [[ $domains = $domains1 ]]; then
			echo $domains >> /tmp/cryptophp.domains
		fi

	done
done
if [[ -s "/tmp/cryptophp.domains" ]]; then
	cat /tmp/cryptophp.domains | mail -s "Please Delete Black List Domains From $HOSTNAME" $Email
fi
