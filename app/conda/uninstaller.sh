#!/bin/bash
set -e

# This script uninstalls the Miniconda Docker setup from the system.
# It removes the Docker image and external volume used for persistence.
# chmod +x uninstaller.sh - Make the script executable

# Ensure the script is run with root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "[ERROR] This script must be run as root. Use: sudo $0"
    exit 1
fi

echo ">> Removing external volume 'conda_app'..."
docker volume rm -f conda_app || echo "[WARN] Volume 'conda_app' not found or already removed."

echo ">> Removing Docker image 'minconda:local'..."
docker image rm -f minconda:local || echo "[WARN] Image 'minconda:local' not found or already removed."

echo "Docker image and volume for 'conda_app' have been removed."
