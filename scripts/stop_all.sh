PS_ID=`ps -ef | grep "generate_app_log_data.sh server001" | grep bash | awk -F" " '{print $2}'`
if [ ! -z "$PS_ID" ]; then
  echo "killing..."$PS_ID
  kill -9 $PS_ID
fi

PS_ID=`ps -ef | grep "generate_app_log_data.sh server002" | grep bash | awk -F" " '{print $2}'`
if [ ! -z "$PS_ID" ]; then
  echo "killing..."$PS_ID
  kill -9 $PS_ID
fi

PS_ID=`ps -ef | grep "generate_app_log_data.sh server003" | grep bash | awk -F" " '{print $2}'`
if [ ! -z "$PS_ID" ]; then
  echo "killing..."$PS_ID
  kill -9 $PS_ID
fi

PS_ID=`ps -ef | grep "generate_app_log_data-kafka.sh server004" | grep bash | awk -F" " '{print $2}'`
if [ ! -z "$PS_ID" ]; then
  echo "killing..."$PS_ID
  kill -9 $PS_ID
fi

