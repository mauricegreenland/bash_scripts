#!/bin/sh

###############################################
#   Reset Local Administrator Password        #
#   ----------------------------------------  #
#   This script will change the local admin   #
#   password, for the account specified in    #
#   $6 and checked against adminUser.         #
#   ----------------------------------------  #
#   The script can be re-purposed by changing #
#   these variables.                          #
#   ----------------------------------------  #
#   M Greenland Feb'20                        #
###############################################
#Initiate User Variables
currentPassword="$4"
newPassword="$5"
accountName="$6"

adminUser="remoteadmin"

#Check Account specified in JSS matches the account you want to change (this is a sanity check)
if [ "$adminUser" = "${accountName}" ]
    then 
        #Check for authentication 
        sudo dscl /Local/Default -authonly "${accountName}" "${currentPassword}" 2>&1 /dev/null
        if [ "$?" != "0" ]; then
            #Exit code was not 0 - password has already been changed so no further action
            echo "No action taken, account already updated! "
        else 
           #Change management account locally on mac
            sudo dscl . passwd /Users/"${accountName}" "${currentPassword}" "${newPassword}"
            echo " Local Admin Account - Password changed! "

            #Report management account password back to JSS
            sudo jamf recon -sshUsername remoteadmin -sshPassword "${newPassword}"
            echo " Local Management Account - password passed to JSS! " 

        fi;

    else
        echo " You are trying to change the wrong account. No Changes! "
fi

