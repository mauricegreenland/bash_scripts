#!/bin/bash
# Script will return all local admin account users
# Except those excluded
##########

admins=$(dscl . -read /Groups/admin GroupMembership | tr " " "\n" | grep -v "GroupMembership:" | egrep -v "root|_sophos|_mbsetupuser|_jss|casper|remoteadmin|lau|cbind|dubremoteadmin")

while read USER; do
    if [[ $(dscl . read /Users/$USER 2>&1>/dev/null; echo $?) == 0 ]]; then
        adminsArr+=("$USER")
    fi
done < <(printf '%s\n' "$admins")

echo "<result>$(printf '%s\n' "${adminsArr[@]}")</result>"