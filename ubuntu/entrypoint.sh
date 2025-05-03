#!/usr/bin/env bash
set -e

# 1. Crear grupo si no existe
if ! getent group "${USER_GID}" >/dev/null; then
  groupadd --gid "${USER_GID}" "${USERNAME}"
fi

# 2. Crear usuario si no existe
if ! id -u "${USERNAME}" >/dev/null 2>&1; then
  useradd --uid "${USER_UID}" \
          --gid "${USER_GID}" \
          --shell /bin/bash \
          --create-home \
          "${USERNAME}"
  # Establece la contraseña (puede venir de ENV)
  echo "${USERNAME}:${USER_PASSWORD}" | chpasswd
  # echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME}
fi

# 3. Generar claves de host SSH si faltan
ssh-keygen -A

# 4. Ajustes mínimos de sshd
#    - Permitimos login con contraseña (o desactivar si usarás autenticación por clave)
sed -i 's/^#PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#PermitRootLogin .*/PermitRootLogin no/'       /etc/ssh/sshd_config

# 5. Arrancar sshd en primer plano (PID 1)
exec /usr/sbin/sshd -D
