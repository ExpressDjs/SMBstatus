# SMBstatus

This program is created to confirm storage is connected as required on boot of linux.
If the storage is not connected as required the script will confirm the storage server is online & try to re-connect 5 times, after 5 times the system will stop trying to connect and log.

Script is looking for the file ".attached" that's in the Samba folder that we are testing, if the file is there the script will close and if not it will try and connect as required.

This only works at the moment if your mount command is stored in "/etc/rc.local" as the script will try to re-run this file if the storage is not connected!


#To use this you must have the following
1. a shared folder on the linux server you want to run
(e.g /usr/local/Linux_Mantance/) 
2. a file named ".attached" in the location that you are testing for
3. the mount command in /etc/rc.local (you can change this in the script if required!)

