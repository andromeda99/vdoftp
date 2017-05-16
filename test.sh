#!/bin/bash

if [ -f /etc/lftp.conf ]; then
echo "lftp is already installed"
yum info lftp
else
echo "lftp is not installed on your system...Installing it now...Please wait..."
sleep 2;
yum install lftp -y
echo "lftp is now installed..."
fi

