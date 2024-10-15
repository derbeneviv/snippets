# attach to docker container's net namespace

get pid of main process of container
```
nsenter -t <PID> -n <command>
```
example
```
nsenter -t 1337 -n ping ya.ru
```
