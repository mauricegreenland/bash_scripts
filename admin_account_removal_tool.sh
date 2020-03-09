#!/bin/bash
#########################
#   Account Removal Tool 
#   
#   Script will remove ALL User accounts and Home Folders
#   in the ADMINS Group EXCEPT users in the ADMINS Whitelist array.
#   
#   M Greenland
#   26 Feb 2020
#   
#########################

#Admins Array - List all admins to ignore
ADMINS=(
    "root"
    "remoteadmin"
    "dubremoteadmin"
    "_sophos"
    "_mbsetupuser"
    "_jss"
    "maurice.greenland"
)

# Verify Users in Admin Whitelist
# for i in "${ADMINS[@]}"; do
#     echo "Admin Whitelisted User : $i"
# done
echo "Whitelisted Users : ${ADMINS[@]}"

#Change Array - Array of users that need admin rights removed
CHANGE=()

# Build an array of all group members of the admin group. Use awk to truncate the first field.
USERS=($(/usr/bin/dscl . read /Groups/admin GroupMembership | /usr/bin/awk '{print substr($0,index($0,$2))}'))

# Verify Users in Admin Group
# for i in "${USERS[@]}"; do
#     echo "Admin Group User: $i"
# done
echo "Users in Admin Group : ${USERS[@]}"

for i in "${USERS[@]}"; do
    skip=
    for j in "${ADMINS[@]}"; do
        [[ $i == $j ]] && { skip=1; echo "$i is Whitelisted - IGNORED!"; break; }
    done
    [[ -n $skip ]] || CHANGE+=("$i")
done

# Verify Users in Change
for i in "${CHANGE[@]}"; do
    echo "CHANGE : $i "
done

# Length of Change
lenCHANGE=${#CHANGE[@]}

# Remove users from Admin Group
if [[ $lenCHANGE -gt 0 ]]
then
    # Users in CHANGE
    echo "Admin Rights to be removed from : ${CHANGE[@]}"

    for (( i=0; i<${lenCHANGE}; i++));
    do
    #Remove User From Admin Group
    sudo dseditgroup -o edit -d ${CHANGE[$i]} -t user admin
    echo "Removed admin rights : ${CHANGE[$i]}"
    #Remove User Account
    sudo dscl . -delete /Users/${CHANGE[$i]}
    echo "Removed User account : ${CHANGE[$i]}"
    #Remove Home Folder
    sudo rm -fR /Users/${CHANGE[$i]}
    echo "Removed Home Folder /Users/${CHANGE[$i]}"
    done
else
    echo "NO Users to be removed. Done!"
fi

