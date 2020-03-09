#!/bin/bash
###############
# Has Meraki Agent
#   
# Will check for Meraki Agent
#################

#Log File
LOG_FILE=/var/log/m_agent.log

if [ -f "$LOG_FILE" ]; then
    echo "$LOG_FILE exists"
    # Profile is present
    echo "<result>True</result>"
    exit 1
else
     echo "$LOG_FILE does NOT exists"
    # Profile is NOT present
    echo "<result>False</result>"
    exit 0   
fi
