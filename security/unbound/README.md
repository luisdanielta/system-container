interface: 0.0.0.0:5053
port: 53

root-hints download
curl -o /var/unbound/etc/root.hints https://www.internic.net/domain/named.cache