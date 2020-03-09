#!/bin/bash
#################
# Script will check if there are items in users
#  Downloads folder that are older than 1 year
#  and not modified in 6 months
#  and remove them to Trash
#################

#Get current user
USER=$(scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }')

echo ${USER};

#Get the current date
FILE_DATE=`date +%Y%m%d`

echo $FILE_DATE

#Get a list of files in Downloads folder
find ~/Downloads/ -type f -maxdepth 1  -exec ls -lah {} \;> ~/Downloads/${FILE_DATE}downloads.txt

#Fix permissions on text file
/usr/sbin/chown $USER /Users/$USER/Downloads/${FILE_DATE}downloads.txt





