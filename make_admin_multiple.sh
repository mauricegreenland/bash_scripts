#!/bin/sh
#########################
#   Add Admin Rights to Multiple Accounts
#   
#   Script will ADD admin rights to ALL 
#   users in the ADMINS ADD array.
#   
#   M Greenland
#   31 March 2020
#   
#########################

#Admins ADD Array - List all USERS to make Admin
ADMINS=(
    "checkadmin"
)

# Verify Users to ADD to Admin Group
echo "Users to ADD to ADMIN Group : ${ADMINS[@]}"

#Change Array - Array of users that need admin rights ADDED
CHANGE=()

for i in "${ADMINS[@]}"; do
    [[ $i == "checkadmin" ]] && { CHANGE+=("$i"); echo "$i added to Change Array"; }
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
    # Number of users in CHANGE
    lenCHANGE=${#CHANGE[@]}
    echo "Admin Rights to be ADDED to : ${CHANGE[@]}"

    for (( i=0; i<${lenCHANGE}; i++));
    do
    # ADD User to Admin Group
    sudo dseditgroup -o edit -a ${CHANGE[$i]} -t user admin
    echo "Admin ADDED to : ${CHANGE[$i]}"
    done
else
    echo "No users to be granted Admin. Done!"
fi

# Build an array of all group members of the admin group. Use awk to truncate the first field.
USERS=($(/usr/bin/dscl . read /Groups/admin GroupMembership | /usr/bin/awk '{print substr($0,index($0,$2))}'))

# Verify Users in Admin Group
echo "All Users in Admin Group : ${USERS[@]}"