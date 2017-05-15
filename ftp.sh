#!/bin/bash
###   Connecting to remote server via LFTP protocol & downloading "VDOPIA_SDK" directory to the current working directory.
###   Please make sure to install lftp package before running this script.
###   You can rename the TARGETFOLDER on line no. 9 if the target folder has changed. Similarly you can also change HOST,USER & PASSWORD
echo "Connecting to remote host 34.203.2.241 via LFTP..."
HOST='34.203.2.241'
USER='vdoftp'
PASS='vdoftp$$12!'
TARGETFOLDER='VDOPIA_SDK'
DESTINATION='/ftp_task'

lftp -f "
open $HOST 
user $USER $PASS 
mirror  $TARGETFOLDER
"
echo "$TARGETFOLDER copied to $DESTINATION successfully"
cd $DESTINATION
ls -l $DESTINATION
exit 0
