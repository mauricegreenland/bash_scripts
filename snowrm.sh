#!/bin/sh
# A Simple Script to Remove Snow Agent Completely 
# Maurice Greenland 30/01/2020

#Loction of Snow Agent
FILE_NAME=/opt/snow

#Snow Agent and xMetering daemon
FILE1=/Library/LaunchDaemons/com.snowsoftware.Inventory.plist
FILE2=/Library/LaunchDaemons/com.snowsoftware.Metering.plist

if [ -f "$FILE1" ] || [ -f "$FILE2" ]; then
    echo "$FILE1 or $FILE2 exits"
    #Stop the snowagent and xMetering daemon processes
    launchctl unload /Library/LaunchDaemons/com.snowsoftware.Inventory.plist
    launchctl unload /Library/LaunchDaemons/com.snowsoftware.Metering.plist
    echo "Snow Agent and xMetering daemon stopped"
    #Delete snowagent and xMetering plists
    sudo rm /Library/LaunchDaemons/com.snowsoftware.Inventory.plist
    sudo rm /Library/LaunchDaemons/com.snowsoftware.Metering.plist
    echo "Snow Agent and xMetering daemon deleted"
else
    echo "No Plists to delete!"
fi

#Delete all installed files, data files and temporary files
if [ -d "$FILE_NAME" ]; then
    echo "$FILE_NAME exists"
	echo "Delete all installed Snow files!"
    sudo rm -rf /opt/snow
    echo "Removed Snow Agent Complete!"
    exit
    EOF
    return 1
else
    echo "No files to delete!"
    exit 0
fi