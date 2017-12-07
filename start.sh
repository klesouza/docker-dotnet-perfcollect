#!/bin/bash

docker build . -f Dockerfile -t ksilva/dotnet-trace
docker rm dotnet-trace -f || true && \
docker run -d -p 5000:5000 \
    -v $(pwd)/data:/tmp/prof:rw \
    --security-opt seccomp=$(pwd)/seccomp.json \
    --name dotnet-trace  \
    ksilva/dotnet-trace