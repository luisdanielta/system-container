#!/usr/bin/env bash
set -e

if [ "$DOCKER_APP" != "true" ]; then
  echo "[INFO] DOCKER_APP is not true. Skipping dockerd."
  exec "$@"
  exit 0
fi

echo "[INFO] Starting Docker daemon..."
dockerd > /var/log/dockerd.log 2>&1 &

while ! docker info > /dev/null 2>&1; do
    sleep 1
done

echo "[INFO] Docker daemon is up"

CONFIG_MARKER="/.docker_configured"
if [ ! -f "$CONFIG_MARKER" ]; then
  echo "[INFO] Applying one-time Docker group configuration..."
  groupadd docker || true
  usermod -aG docker "${USERNAME}" || true
  touch "$CONFIG_MARKER"
else
  echo "[INFO] Docker group already configured. Skipping."
fi

exec "$@"