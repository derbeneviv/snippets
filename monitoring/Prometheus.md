# Prometheus

## Join two metrics when they have different label names (but label values are same)

Here we have a metric `longhorn_volume_actual_size_bytes` which has namespaces in label `pvc_namespace`  
and a metric `kube_namespace_labels` which has namespaces in label `namespace`  
We want to get all metrics for `longhorn_volume_actual_size_bytes` in all namespaces NOT labeled by `team: "foo"`

```
longhorn_volume_actual_size_bytes{} * on(pvc_namespace) group_left(label_team) label_replace(kube_namespace_labels{label_team!="foo"}, "pvc_namespace", "$1", "namespace", "(.*)")
```

## run alert on joined metrics
see example above  
we want to calculate operator on two metrics (in this example we calculate space on volume)  
`longhorn_volume_actual_size_bytes`  
`longhorn_volume_capacity_bytes`

basic query looks like:
```
(longhorn_volume_actual_size_bytes / longhorn_volume_capacity_bytes) * 100 > 90
```

now we add groups (note the parenthesis)
```
(longhorn_volume_actual_size_bytes{} * on(pvc_namespace) group_left(label_team) label_replace(kube_namespace_labels{label_team="foo"}, "pvc_namespace", "$1", "namespace", "(.*)")) / on(volume, node,pvc_namespace,pvc) (longhorn_volume_capacity_bytes{} * on(pvc_namespace) group_left(label_team) label_replace(kube_namespace_labels{label_team="foo"}, "pvc_namespace", "$1", "namespace", "(.*)")) * 100 > 90
```

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
