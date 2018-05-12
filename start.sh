#!/bin/bash

docker build . -f Dockerfile-app -t ksilva/dotnet-trace-app
docker rm dotnet-trace-app -f || true && \
docker run -p 5000:5000 \
    -v $(pwd)/data:/tmp/prof:rw \
    -e "COMPlus_PerfMapEnabled=1" \
    -e "COMPlus_EnableEventLog=1" \
    -e "RESULT_PATH=/tmp/prof/result.txt" \
    --security-opt seccomp=$(pwd)/seccomp.json \
    --name dotnet-trace-app  \
    ksilva/dotnet-trace-app