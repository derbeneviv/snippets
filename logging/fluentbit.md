# Fluent-bit

## log to metrics
Add a prometheus metric from fluentbit logs
Exclude one regex, match other
ORDER OF REGEXEs\EXCLUDES IS IMPORTANT

```
  filters: |
    [FILTER]
        Name kubernetes
        Match kube.*
        Merge_Log On
        Merge_Log_Trim On
        Keep_Log Off
        K8S-Logging.Parser On
        K8S-Logging.Exclude On
        Buffer_Size 30MB
    
    [FILTER]
        Name  parser
        Match kube.var.log.containers.dex-*
        Key_Name message
        Parser json_isotime
        Reserve_Data On
    
    [FILTER]
        Name parser
        Match kube.var.log.containers.dex-*
        Key_Name msg
        Parser dex-users
        Reserve_Data On
        Preserve_Key On
    
    [FILTER]
        Name               log_to_metrics
        match              kube.var.log.containers.dex-*
        tag                dex-users
        metric_mode        counter
        metric_name        dex_users
        metric_description This metric counts dex successful logins
        label_field        username
        kubernetes_mode    On
        Exclude            groups ^(?!.*CIBAD.*).*
        Regex              username .+

    [FILTER]
        Name         lua
        Match        kube.*
        script       /fluent-bit/scripts/dedot.lua
        call         copy_routing_fields_with_underscore

    [FILTER]
        Name         lua
        Match        kube.*
        script       /fluent-bit/scripts/dedot.lua
        call         dedot

  ## https://docs.fluentbit.io/manual/pipeline/outputs
  outputs: |
    [OUTPUT]
        name               prometheus_exporter
        match              *
        host               0.0.0.0
        port               2021
  customParsers: |
    [PARSER]
      Name json_isotime
      Format json
      Time_Key time
      Time_Format %Y-%m-%dT%H:%M:%S%z
    
    [PARSER]
      Name dex-users
      Format regex
      Regex login successful: connector "(?<connector>[^"]*)", username="(?<username>[^"]*)", preferred_username="(?<preferred_username>[^"]*)", email="(?<email>[^"]*)", groups=(?<groups>[^\]]*\]).*
```
