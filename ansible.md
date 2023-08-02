## print all hosts + their IP
```
ansible-inventory -i inventory/hoylu_qdev_eastus_infra_azure_rm.yml --list | jq '._meta.hostvars | with_entries(.value |= .ansible_host)'
```
