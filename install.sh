#!/bin/bash
#Created by Denis O'Leary to install onto system

_date=$(date +"%T-%d/$m/%y");
_hn=(hostname);
install_server="servers.txt"

if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
fi

if [ -d "/etc/OLeary" ]
	then echo "folder is created, copying the install files" && sudo cp SMBstatus.sh /etc/OLeary
else
	echo "Creating folder and copy file install files" && sudo mkdir /etc/OLeary && sudo cp SMBstatus.sh /etc/OLeary
fi

echo " "

echo "Creating the required cronjob for SMB status"
sudo echo "@reboot root /etc/OLeary/SMBstatus.sh" >> /etc/cron.d/SMBcheck


echo "Creating log file rotation"
if [ -d "/etc/logrotate.d" ]
        then echo "LogRotate is installed, Copying file as required" && sudo cp SMBstatus.conf /etc/logrotate.d/ && sudo chmod 0644 /etc/logrotate.d/SMBstatus.conf && echo $_date" - installed " $HOSTNAME >> $install_server
else
        echo "Please install log rotate and manually copy NetTest.conf to /etc/logrotate.d/"
fi

exit;
