#!/usr/bin/env bash
set -e

# Create required directory for sshd
mkdir -p /var/run/sshd

# Wait briefly to ensure volumes are mounted (important on container restarts)
sleep 2

# Generate SSH host keys if they don't exist
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    echo "Generating SSH host keys..."
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' -q
    ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N '' -q
    #ssh-keygen -A
fi

# Enable password authentication and disable root login
sed -i 's/^#PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config

if grep -q "^AllowUsers" /etc/ssh/sshd_config; then
    sed -i "s/^AllowUsers.*/AllowUsers $USERNAME/" /etc/ssh/sshd_config
else
    echo "AllowUsers $USERNAME" >> /etc/ssh/sshd_config
fi

# Start the SSH daemon
echo "Starting SSH daemon..."
exec /usr/sbin/sshd -D