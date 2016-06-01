#!/bin/bash



if [ $# -ne 5 ]; then
    echo "Invalid number of arguments."
    echo "Usage ./generate_access_log_data.sh <server_name> <app_name> <app_version> <is_more_error?(0|1)> <is_slow?(0|1)>"
    exit 1
fi

SERVER_NAME=$1
APP_NAME=$2
APP_VERSION=$3
ERR_FLAG=0
SLOW_FLAG=0
SLEEP_DURATION=0.1

temp0=`echo $4 | grep "^-\?[0-1]$"`
if [ -z "$temp0" ]; then
    ERR_FLAG=0
else
    ERR_FLAG=$temp0
fi

temp1=`echo $5 | grep "^-\?[0-1]$"`
if [ -z "$temp1" ]; then
    SLOW_FLAG=0
else
    SLOW_FLAG=$temp1
fi

while true
do
    # Calculate status code
    ## generate random number between 0 and 50 for normal state
    ## generate random number between 1 and 20 for good state
    if [ $ERR_FLAG -eq 0 ]; then 
        x1=`gshuf -i 1-50 -n 1`
    else
        x1=`gshuf -i 1-20 -n 1`
    fi

    ## 1 out of 50 in normal state and 1 out of 20 in bad state will be 404
    ## 1 out of 50 in normal state and 1 out of 20 in bad state will be 503
    ## Rest every thing will be 200
    if [ $x1 -eq 4 ]; then
        status_code=404
    elif [ $x1 -eq 5 ]; then
        status_code=503
    else
        status_code=200
    fi

    x2=`gshuf -i 100-2250 -n 1`
    if [ $SLOW_FLAG -eq 0 ]; then
        latency=`echo $(printf %0.3f $(echo "scale=3; $x2/1000" | bc))`
    else
        latency=`echo $(printf %0.3f $(echo "scale=3; $x2/1000*5" | bc))`
        SLEEP_DURATION=0.5
    fi


    # Generate the log file in the format
    ## time stamp|server|app name|app version|GET|url|status code|latency|referral
    echo `date`"|"$SERVER_NAME"|"$APP_NAME"|"$APP_VERSION"|GET|http://www.homepage.com/|"$x1"|"$status_code"|"$latency"|referral_url" >> accesslog-$SERVER_NAME-$APP_NAME-$APP_VERSION.log

    echo "..."
    sleep $SLEEP_DURATION
done

