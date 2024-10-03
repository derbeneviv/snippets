## get all images in cluster
```
k get pods --all-namespaces -o go-template='{{range .items}}{{.metadata.name}}{{"->"}}{{range .spec.containers}}{{.image}}{{end}}{{"\n"}}{{end}}' 
k get pods --all-namespaces -o go-template='{{range .items}}{{.metadata.name}}{{"->"}}{{range .spec.initContainers}}{{.image}}{{end}}{{"\n"}}{{end}}' 
```

## get resources' name w\o prefix
```
kubectl get node --no-headers -o custom-columns=":metadata.name"
```

## stamp roles on all nodes
```
for NODE_HOSTNAME in $(kubectl get node --no-headers -o custom-columns=":metadata.name"); do
  nodegroup=$(kubectl get node "${NODE_HOSTNAME}" --output=jsonpath='{.metadata.labels.eks\.amazonaws\.com\/nodegroup}')
  kubectl label node "${NODE_HOSTNAME}" --overwrite=true "node-role.kubernetes.io/${nodegroup}=yes" || echo "node labeling failed"
done
```

## get spec on resource
```
kubectl explain <spec path>
# i.e.
kubectl explain pod.spec
```


## defrag and compact current etcd node
https://discuss.kubernetes.io/t/etcdserver-mvcc-database-space-exceeded/22806/3  

```
REVISION=$(ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/peer.crt --key=/etc/kubernetes/pki/etcd/peer.key endpoint status --write-out="json" | egrep -o '"revision":[0-9]*' | egrep -o '[0-9].*')
ETCDCTL_API=3 etcdctl \
	--endpoints=https://127.0.0.1:2379 \
	--cacert=/etc/kubernetes/pki/etcd/ca.crt \
	--cert=/etc/kubernetes/pki/etcd/peer.crt \
	--key=/etc/kubernetes/pki/etcd/peer.key \
	compact ${REVISION}
ETCDCTL_API=3 etcdctl \
	--endpoints=https://127.0.0.1:2379 \
	--cacert=/etc/kubernetes/pki/etcd/ca.crt \
	--cert=/etc/kubernetes/pki/etcd/peer.crt \
	--key=/etc/kubernetes/pki/etcd/peer.key \
	defrag
```

## count all objects in etcd
https://gist.github.com/dkeightley/8f2211d6e93a0d5bc294242248ca8fbf
```
for key in `etcdctl get --prefix --keys-only /`
do
  size=`etcdctl get $key --print-value-only | wc -c`
  count=`etcdctl get $key --write-out=fields | grep \"Count\" | cut -f2 -d':'`
  if [ $count -ne 0 ]; then
    versions=`etcdctl get $key --write-out=fields | grep \"Version\" | cut -f2 -d':'`
  else
    versions=0
  fi
  total=$(($size * $versions))
  echo $total $size $versions $count $key >> /tmp/etcdkeys.txt
done
```


## clear resource for re-creating 
```
k get type/name -n namespace -o json | jq 'del(.metadata.generation, .metadata.annotations, .metadata.creationTimestamp, .metadata.resourceVersion, .metadata.uid, .status )'
```
