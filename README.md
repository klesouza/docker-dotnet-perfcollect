# Idea
The idea is to provide a base image to enable the collection of trace logs for a .NET Core applications running in a docker container. The reports are not very useful yet, but you can have an idea about GC, allocation and exceptions thrown.

# How to use
```bash
./build-docker-base.sh
```

Navigate to `examples` folder

```bash 
./start.sh
```

Files will be generated in the `data` folder in the host machine.

## References
https://github.com/dotnet/coreclr/blob/master/Documentation/project-docs/linux-performance-tracing.md

https://github.com/dotnet/corefx-tools/blob/master/src/performance/perfcollect/perfcollect
