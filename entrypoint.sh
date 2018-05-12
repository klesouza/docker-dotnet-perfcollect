#!/bin/bash

if ! pgrep dotnet > /dev/null 
then
    echo "running dotnet"
    dotnet /code/bin/Debug/netcoreapp2.0/linux-x64/publish/code.dll > /dev/null &
fi
sleep 5
echo "running perf"
DATE=`date '+%Y%m%d%H%M%S'`
f="/tmp/prof/perfsession$DATE"
/tmp/perfcollect collect $f > /tmp/prof/log1.txt & 
echo $! > /tmp/perfid
jobs
echo "calling endpoint"
curl http://localhost:5000/api/home -sS > /dev/null

echo "finishing collection"
jobs
PERF_ID=`cat /tmp/perfid`
echo $PERF_ID
wait $PERF_ID
kill -s SIGINT $PERF_ID
while ps -p $PERF_ID > /dev/null 
do
    jobs
    sleep 10
    kill -s SIGTSTP %1
done
ps -p $PERF_ID
jobs
