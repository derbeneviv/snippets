## get all images in cluster
```
k get pods --all-namespaces -o go-template='{{range .items}}{{.metadata.name}}{{"->"}}{{range .spec.containers}}{{.image}}{{end}}{{"\n"}}{{end}}' 
k get pods --all-namespaces -o go-template='{{range .items}}{{.metadata.name}}{{"->"}}{{range .spec.initContainers}}{{.image}}{{end}}{{"\n"}}{{end}}' 
```
