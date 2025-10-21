## This command will disable systemd-resolved
Is required to disable systemd-resolved in your machine to use the DNS server of your choice.
```bash
systemctl disable systemd-resolved.service
systemctl stop systemd-resolved
```