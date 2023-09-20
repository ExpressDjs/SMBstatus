# SMBstatus

This program is created to confirm storage is connected as required on boot of linux.
If the storage is not connected as required the script will confirm the storage server is online & try to re-connect 5 times, after 5 times the system will stop trying to connect and log.

Script is looking for the file ".attached" that's in the Samba folder that we are testing, if the file is there the script will close and if not it will try and connect as required.

