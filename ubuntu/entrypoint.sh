#!/usr/bin/env bash
set -euo pipefail

export PATH=/opt/conda/bin:$PATH

if [ -f /opt/conda/etc/profile.d/conda.sh ]; then
  . /opt/conda/etc/profile.d/conda.sh
else
  # Fallback alias if initialization script is missing
  alias conda="/opt/conda/bin/conda"
fi

# Path to the password file
PASSWORD_FILE=/password.txt

# Exit if password file is missing
if [[ ! -f "${PASSWORD_FILE}" ]]; then
  echo "ERROR: ${PASSWORD_FILE} file not found."
  exit 1
fi

# Read and sanitize password (remove CR/LF)
USER_PASSWORD="$(tr -d '\r\n' < "${PASSWORD_FILE}")"

# Default to environment variables if set, otherwise use these defaults
: "${USERNAME:=user}"
: "${USER_UID:=1000}"
: "${USER_GID:=1000}"

# Create group and user
groupadd --gid "${USER_GID}" "${USERNAME}"
useradd \
  --uid "${USER_UID}" \
  --gid "${USER_GID}" \
  --create-home \
  --shell /bin/bash \
  "${USERNAME}"

# Set user password and grant passwordless sudo
echo "${USERNAME}:${USER_PASSWORD}" | chpasswd
echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/${USERNAME}"
chmod 0440 "/etc/sudoers.d/${USERNAME}"

# Prepare SSH daemon and enable password login, disable root login
mkdir -p /var/run/sshd
ssh-keygen -A
sed -i 's/^#PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#PermitRootLogin .*/PermitRootLogin no/'          /etc/ssh/sshd_config

# Execute the container’s main command (e.g., sshd -D)
exec "$@"
