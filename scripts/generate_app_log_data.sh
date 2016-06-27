#!/bin/bash


# Check for reuired 4 parameters; else exit
if [ $# -ne 4 ]; then
    echo "Invalid number of arguments."
    echo "Usage ./generate_app_log_data.sh <server_name> <app_name> <app_version> <is_app_in_bad_state?(0|1)>"
    exit 1
fi

# Initialize variables
SERVER_NAME=$1
APP_NAME=$2
APP_VERSION=$3
SERVER_FLAG=0

# Ensure the variable 4 is either a 0 or 1; for all other values default it to 0
temp0=`echo $4 | grep "^-\?[0-1]$"`
if [ -z "$temp0" ]; then
    SERVER_FLAG=0
else
    SERVER_FLAG=$temp0
fi

# Perform infinite loop; ctrl+c to exit
while true
do
    # Calculate message type
    ## generate random number between 1 and 100 for normal state
    ## generate random number between 1 and 25 for bad state
    if [ $SERVER_FLAG -eq 0 ]; then 
        x1=`shuf -i 1-100 -n 1`
    else
        x1=`shuf -i 1-25 -n 1`
    fi

    ## if x1 has a value of 1 or 2, then CRIT
    ## if x1 has a value of 3 or 4 or 5, then ERROR
    ## if x1 has a value of 6 or 7 or 8 or 9 or 10, then WARN
    ## else everything is INFO
    if [ $x1 -eq 1 -o $x1 -eq 2 ]; then
        msg_type=CRIT
    elif [ $x1 -eq 3 -o $x1 -eq 4 -o $x1 -eq 5 ]; then
        msg_type=ERROR
    elif [ $x1 -eq 6 -o $x1 -eq 7 -o $x1 -eq 8 -o $x1 -eq 9 -o $x1 -eq 10 ]; then
        msg_type=WARN
    else
        msg_type=INFO
    fi

    # Arbitarily generate a 4 digit random number to append to the log message
    x2=`shuf -i 1000-9999 -n 1`

    # Generate the app log file in the format
    ## time stamp|server|app name|app version|(INFO|WARN|ERROR|CRIT)|log message
    echo `date`"|"$SERVER_NAME"|"$APP_NAME"|"$APP_VERSION"|"$msg_type"|log msg "$x2";;" >> applog-$SERVER_NAME.log

    sleep 0.25
done

