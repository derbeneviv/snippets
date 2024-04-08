# attach to docker container's net namespace

get pid of main process of container
```
nsenter -t <PID> -n <command>
```
