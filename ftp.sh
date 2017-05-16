#!/bin/bash
###   Connecting to remote server via LFTP protocol & downloading "VDOPIA_SDK" directory to the users home directory.
###   Please make sure to install lftp package before running this script.
###   You can rename the TARGETFOLDER on line no. 10 if the target folder has changed. Similarly you can also change HOST,USER,PASSWORD,TARGET & LOCAL folder.
connect_remote_FTP () {
        echo "Connecting to remote host 34.203.2.241 via LFTP..."
        sleep 2;
        HOST='34.203.2.241'
        USER='vdoftp'
        PASS='vdoftp$$12!'
        TARGETFOLDER='VDOPIA_SDK'
        LOCAL='/home'
        lftp -e "
        open $HOST
        user $USER $PASS
        lcd $LOCAL
        mirror  $TARGETFOLDER
        bye
        "
        x=`echo $?`
        if [ $x == 0 ]; then
        echo "$TARGETFOLDER copied to $LOCAL successfully"
        ls -l $LOCAL
        exit 0
        else
        echo "Please try again"
        exit 1
        fi
}

if [ -f /etc/lftp.conf ]; then
	echo "lftp is already installed"
	#yum info lftp
	connect_remote_FTP
	exit 0
else
	echo "lftp is not installed on your system...Installing it now...Please wait..."
	sleep 2;
	yum install lftp -y
	echo "lftp is now installed..."
	connect_remote_FTP
	exit 0
fi     



