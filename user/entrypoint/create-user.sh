#!/usr/bin/env bash
set -e

# Create group and user
if ! getent group "${USERNAME}" >/dev/null; then
  groupadd --gid "${USER_GID}" "${USERNAME}"
fi

if ! id "${USERNAME}" >/dev/null 2>&1; then
  useradd \
    --uid "${USER_UID}" \
    --gid "${USER_GID}" \
    --create-home \
    --shell /bin/bash \
    "${USERNAME}"
fi

# Set user password
if  ! id "${PSWD}" >/dev/null 2>&1; then
  echo "${USERNAME}:${PSWD}" | chpasswd
  echo "Password for user ${USERNAME} set to ${PSWD}"
fi

# Set user password and grant passwordless sudo
echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/${USERNAME}"
chmod 0440 /etc/sudoers.d/${USERNAME}
chown -R ${USER_UID}:${USER_GID} /home/${USERNAME}

exec "$@"