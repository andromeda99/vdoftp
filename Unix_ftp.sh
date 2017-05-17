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
        lftp -e "
        open $HOST
        user $USER $PASS
        mirror  $TARGETFOLDER
        bye
        "
        x=`echo $?`
        if [ $x == 0 ]; then
        echo "$TARGETFOLDER copied to $LOCAL successfully"
        ls -l
        exit 0
        else
        echo "Please try again"
        exit 1
        fi
}

if [ -f /usr/local/bin/lftp ]; then
	cd /users/$USER
	echo "lftp is already installed"
	connect_remote_FTP
	exit 0
else
	echo "lftp is not installed on your system...Installing it now...Please wait..."
	cd /users/$USER
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew doctor
	mkdir  ~/.lftp
	touch ~/.lftp/rc
	echo "set ssl:verify-certificate no" >> ~/.lftp/rc
	echo "set ssl:check-hostname no" >> ~/.lftp/rc
	echo "set ftp:ssl-force false" >> ~/.lftp/rc
	echo "set ftp:ssl-protect-list false" >> ~/.lftp/rc
	echo "set ftp:ssl-allow false" >> ~/.lftp/rc
	brew install lftp
	sleep 2;
	echo "lftp is now installed..."
	connect_remote_FTP
	exit 0
fi     



