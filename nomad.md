#Remove dead jobs:
```
curl -X PUT http://localhost:4646/v1/system/gc
```

#Fast cat:
```
nginxcontainername=$(docker ps --format '{{.Names}}'| grep infra-nginx); docker exec -ti ${nginxcontainername} cat /etc/nginx/conf.d/load-balancer.conf
```

#consul dump all:
```
consul kv get -recurse
```

#run terraform.py:
```
./terraform.py -p azure -a hoylu-dev-us -r east-us -e dev -s nomad-infra -m plan
```

#run ansible-playbook:
```
ansible-playbook -i inventory/hoylu_dev_eastus_infra playbooks/orchestrated/consul_provision.yml --check --diff -u superadmin --private-key /vagrant/hoylu_devops_id_rsa
```

#get all ansible variables:
```
ansible  -i inventory/hoylu_dev_eastus_infra -m setup dev-hoylu-consul-1-wan.eastus.cloudapp.azure.com -u superadmin --private-key /vagrant/hoylu_devops_id_rsa
```

# clean consul key cache
```
rm /opt/consul/serf/local.keyring
```

# clear folder by ansible
```
ansible -i inventory/hoylu_dev_eastus_infra es_servers -a 'bash -c "rm -rf  /opt/es/*"' -u superadmin --private-key /vagrant/hoylu_devops_id_rsa
```


