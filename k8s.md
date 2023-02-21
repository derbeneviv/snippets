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
