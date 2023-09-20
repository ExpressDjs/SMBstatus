#/bin/bash
#Created by Denis O'Leary to uninstall NetTest

# Checking for root user
if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
fi

echo "This application will uninstall and remove the services for NetTest"

echo "Deleting the crontab file for script"
sudo rm -rf /etc/cron.d/SMBcheck

echo "Deleting the script for the NetTest"
sudo rm -rf /etc/OLeary/SMBstatus.sh

echo "Deleting the log rotation file"
sudo rm -rf /etc/logrotate.d/SMBstatus.conf


exit;
