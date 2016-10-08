nohup ./generate_app_log_data.sh server001 ms 1.0 1 > /tmp/nohup.out 2>&1 &
echo "starting server:server001 | app:ms | version:1.0..."`ps -ef | grep "generate_app_log_data.sh server001" | grep bash | awk -F" " '{print $2}'`

nohup ./generate_app_log_data.sh server002 ms 1.0 0 > /tmp/nohup.out 2>&1 &
echo "starting server:server002 | app:ms | version:1.0..."`ps -ef | grep "generate_app_log_data.sh server002" | grep bash | awk -F" " '{print $2}'`

nohup ./generate_app_log_data.sh server003 ms 1.0 0 > /tmp/nohup.out 2>&1 &
echo "starting server:server003 | app:ms | version:1.0..."`ps -ef | grep "generate_app_log_data.sh server003" | grep bash | awk -F" " '{print $2}'`

nohup ./generate_app_log_data-kafka.sh server004 ms 2.0 1 > /tmp/nohup.out 2>&1 &
echo "starting server:server004 | app:ms | version:2.0..."`ps -ef | grep "generate_app_log_data-kafka.sh server004" | grep bash | awk -F" " '{print $2}'`
