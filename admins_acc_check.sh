#!/bin/bash
#########################
#   Remove Admin Rights
#   
#   Script will check if the specified
#   account is on the machine
#   
#   M Greenland
#   19 Feb 2020
#   
#########################

#Variables
# Admin Account you want to check exists
adminAccount="$4"

# All Accounts (excluding system accounts)
allAccounts=($( dscl /Local/Default -list /Users uid | awk '$2 >= 100 && $0 !~ /^_/ { print $1 }' ))

# Result of search
RESULT=()

# Verify allAccounts
for i in "${allAccounts[@]}"; do 
   
    if [[ $i == $adminAccount ]]
    then
        echo "$i is on this machine!"; 
        RESULT+=("$i")
    else
        echo "Account : $i"
        continue
    fi
done

lenRESULT=${#RESULT[@]}

#Check
if [[ $lenRESULT -gt 0 ]]
then
    echo "$adminAccount found!"
    exit 0
else
    echo "Account $adminAccount not found!"
    exit 1
fi