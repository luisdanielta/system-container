#!/usr/bin/env bash
set -euo pipefail

# Starts the Docker daemon in the background
dockerd &

# If the docker daemon fails to start, exit with an error
if ! docker info > /dev/null 2>&1; then
    echo "Docker daemon failed to start"
    exit 1
fi

echo "Docker daemon started successfully"
groupadd docker || true
usermod -aG docker "${USERNAME}" || true

exec "$@"