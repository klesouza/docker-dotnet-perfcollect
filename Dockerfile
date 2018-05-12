FROM microsoft/dotnet:2.0.3-sdk

RUN apt-get update \
    && apt-get install -y linux-tools lttng-modules-dkms liblttng-ust-dev lttng-tools zip

RUN export COMPlus_PerfMapEnabled=1
RUN mkdir /code && mkdir /tmp/prof
WORKDIR /tmp
RUN git clone https://github.com/dotnet/corefx-tools.git --depth=1 \
    && cd corefx-tools \
    && git checkout src/performance/perfcollect/perfcollect \
    && cp src/performance/perfcollect/perfcollect /tmp/perfcollect \
    && chmod +x /tmp/perfcollect
WORKDIR /code

#RUN dotnet new webapi \
COPY app/api/* ./
RUN dotnet publish --self-contained -r linux-x64

RUN cp /root/.nuget/packages/runtime.linux-x64.microsoft.netcore.app/2.0.0/tools/crossgen \
    /code/bin/Debug/netcoreapp2.0/linux-x64/publish/
RUN cp /root/.nuget/packages/runtime.linux-x64.microsoft.netcore.app/2.0.0/tools/crossgen \
    /usr/share/dotnet/shared/Microsoft.NETCore.App/2.0.3/

RUN export COMPlus_PerfMapEnabled=1 \
    && export COMPlus_EnableEventLog=1
    
#CMD ./entrypoint.sh
RUN apt-get -y install babeltrace
WORKDIR /code/bin/Debug/netcoreapp2.0/linux-x64/publish
COPY run-perf.sh .
COPY entrypoint.sh .
COPY dntrace.sh .
COPY dnstats.py .
RUN chmod +x run-perf.sh & chmod +x entrypoint.sh && chmod +x dntrace.sh 
#ENTRYPOINT ["./entrypoint.sh"]
RUN ./run-perf.sh &
CMD ["dotnet", "code.dll"]