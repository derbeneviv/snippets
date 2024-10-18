# Prometheus

## Run query on pods chosen by pod labels, when pod labels are not in metric labels
We have a query. For example number of restarts of pods in namespace foo:
```
kube_pod_container_status_restarts_total{namespace="foo"}
```
But we want to run it only on pods with label 'bar=baz'  
Pods with this label can be found using query (if we set up passing labels in kube-state-metrics with metric-labels-allowlist)  
https://github.com/kubernetes/kube-state-metrics/blob/main/docs/developer/cli-arguments.md  
```
kube_pod_labels{label_bar="baz"}
```
To join those we need to run:
```
kube_pod_container_status_restarts_total{namespace="foo"} * on (pod,namespace) group_right kube_pod_labels{label_bar="baz"}
```
