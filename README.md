# How to use
```
./start.sh
```

1. In one shell 

``` 
docker exec -it --privileged dotnet-trace /tmp/perfcollect collect /tmp/prof/perfsession -pid $(pgrep dotnet)
```
2. Open a new shell and make a request
```
docker exec -it dotnet-trace curl http://localhost:5000/api/values
```
3. In the first shell stop the collection (Crtl+C) 

4. Files will be generated in the /data folder in the host machine