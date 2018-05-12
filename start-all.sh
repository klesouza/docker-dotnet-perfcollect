#!/bin/bash
trap destroy INT QUIT TERM PIPE HUP
# Start the first process
dotnet /code/bin/Debug/netcoreapp2.0/linux-x64/publish/code.dll &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_first_process: $status"
  exit $status
fi
echo "dotnet started"
sleep 10;
# Start the second process
/code/dntrace.sh -p $(pgrep dotnet) -d 30 alloc gc heap exc &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_second_process: $status"
  exit $status
fi
echo "tracing started"
sleep 5;
curl http://localhost:5000/api/values
# Naive check runs checks once a minute to see if either of the processes exited.
# This illustrates part of the heavy lifting you need to do if you want to run
# more than one service in a container. The container exits with an error
# if it detects that either of the processes has exited.
# Otherwise it loops forever, waking up every 60 seconds

while sleep 60; do
  ps aux |grep dotnet |grep -q -v grep
  PROCESS_1_STATUS=$?
  # If the greps above find anything, they exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit 1
  fi
done