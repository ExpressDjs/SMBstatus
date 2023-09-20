#!/bin/bash
# Created by Denis O'Leary to test for shared storage attached at boot
# Verison 1.1 (11/07/2023)

server_and_port="REMOTE_SERVER_IP/FQDN 445"
testfile="PATH_TO_TEST_FILE/.attached"
_date=$(date +"%m-%d-%y %H:%M:%S");
n=1
log="/var/log/OLearys/SMB_Check.log"

#Check for root
if [ "$EUID" -ne 0 ]
        then echo "Pleae run as root"
        exit
fi

#creating log file for test
if [ -d "/var/log/OLearys/" ]
	then echo "SMB check ran at" $_date >> $log
else
	echo "Creating log folder" && mkdir /var/log/OLearys && echo "SMB check ran at" $_date >> $log
fi

#Check if the file is present
if [ -e "$testfile" ];
then
  echo "drive is already mounted." && echo $_date" :Storage is connected as required" >> $log
else
	if [[ -x "$(command -v nc)" ]];
	then
		until [ "$n" -ge 6 ]
		do
			if ( nc -zv -w 1 $server_and_port 2>&1 >/dev/null );
			then
		    		echo $_date": SMB server is online - trying to re-mount as required" >> $log && /etc/rc.local;
					if [ -e "$testfile" ];
					then
						echo "Storage is connected as require" && echo $_date" :SMB Storage is connected" >> $log && exit
					else
						echo "Not connected, Trying again!" $n"/5" && echo $_date": SMB Storage is not connected" >> $log
					fi
			else
		    		echo $_date": SMB Server is offline - Trying again" $n"/5" &&  echo $_date": SMB Server is offline trying to connect" $n"/5" >> $log
			fi
		n=$((n+1))
		sleep 10
		done
			echo $_date": SMB server connection failed. Please check server config and reboot again" >> $log
	else
		echo "netcat isn't installed - install and try again" && echo $_date": Netcat is not installed onto the host, Please install and try again" >> $log && exit;
	fi
fi

exit;
