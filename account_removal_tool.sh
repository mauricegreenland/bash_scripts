#!/bin/bash
#########################
#   Account Removal Tool 
#   
#   Script will remove a specified USER account and Home Folder
#   
#   M Greenland
#   26 Feb 2020
#   
#########################

# Set Variables
userName=${4} 


# Check that a User Account Variable has been set 
if [[ -z ${userName} ]]; then
    echo "Username varibale NOT set"
    exit 1
else
    echo  "Username variable set ${userName}"

        # Check for the User account you want to delete
        if [[ -e "/Users/${userName}" ]]; then

            echo "${userName} exists"

            # Remove User Account
            sudo sysadminctl -deleteUser ${userName}
            sudo rm -Rf /Users/${userName}

        else

            echo "${userName} does not exist!"
            exit 2
        fi
fi

# Exit Code
if [ $? -eq 0 ]; then
    echo " [0] Successfully deleted ${userName}"
    exit 0
    else
    echo "[1] Nothing Deleted!" 
    exit 1
fi





