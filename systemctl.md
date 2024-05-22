# show logs from last run of unit

```
# get InvocationID
systemctl show --value -p InvocationID openipmi

#run journalctl
journalctl _SYSTEMD_INVOCATION_ID=$InvocationId
```
one-liner
```
journalctl _SYSTEMD_INVOCATION_ID=$(systemctl show --value -p InvocationID openipmi)
```
