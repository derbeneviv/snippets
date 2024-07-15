# Prometheus

## Join two metrics when they have different label names (but label values are same)

Here we have a metric `longhorn_volume_actual_size_bytes` which has namespaces in label `pvc_namespace`  
and a metric `kube_namespace_labels` which has namespaces in label `namespace`  
We want to get all metrics for `longhorn_volume_actual_size_bytes` in all namespaces NOT labeled by `team: "foo"`

```
longhorn_volume_actual_size_bytes{} * on(pvc_namespace) group_left(label_team) label_replace(kube_namespace_labels{label_team!="foo"}, "pvc_namespace", "$1", "namespace", "(.*)")
```
