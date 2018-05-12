#!/bin/bash
echo "starting perf"
while true; do
    if pgrep dotnet > /dev/null 
    then
        echo "dotnet found...collecting"
        DATE=`date '+%Y%m%d%H%M%S'`
        f="/tmp/prof/perfsession$DATE"
        #/tmp/perfcollect collect $f -pid $(pgrep dotnet) > /tmp/prof/log1.txt &
        /code/dntrace.sh -p $(pgrep dotnet) -d 60 alloc gc heap exc # > $RESULT_PATH
        break
    fi
done
