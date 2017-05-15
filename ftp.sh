#!/bin/bash
###   Connecting to remote server via LFTP protocol & downloading "VDOPIA_SDK" directory to the current working directory.
###   Please make sure to install lftp package before running this script.
###   You can rename the TARGETFOLDER on line no. 10 if the target folder has changed. Similarly you can also change HOST,USER,PASSWORD,TARGET & LOCAL folder.
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
fi
