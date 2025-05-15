## Network system

sudo nano /etc/sysctl.conf
net.ipv4.ip_forward = 1
sudo sysctl -p

Example creation command:
docker network create --driver=ipvlan --subnet=192.168.1.0/24 --gateway=192.168.1.1 -o parent=enp1s0 lan_net