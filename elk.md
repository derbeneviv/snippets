# setup opendistro securityadmin
```
cd /usr/share/elasticsearch/plugins/opendistro_security/tools/
bash ./securityadmin.sh -cd ../securityconfig/ -icl -nhnv -cacert ../../../config/certificates/ca.crt -cert ../../../config/certificates/admin-cert.crt  -key ../../../config/certificates/admin-key.crt -h 10.11.4.7
```

# cluster health
```
curl -k -u "elastic:${pass}"  https://${host}:9200/_cluster/health | jq .
```

# list indeces
```
curl -k -u "elastic:${pass}"  https://${host}:9200/_cat/indices/
```

# drop index
```
curl -XDELETE -k -u "elastic:${pass}"  https://${host}:9200/${index_name}
```

```
curl -XDELETE -k -u "elastic:Ye3YUcEhzl3s37KM1bhi"  https://10.11.4.6:9200/logstash-2020.12.01
```
