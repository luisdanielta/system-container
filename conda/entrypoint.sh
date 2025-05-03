#!/bin/sh
set -e

# Copies conda configuration to the expected location
cp -a /tmp/.condarc /opt/conda

mkdir -p /opt/conda/envs /opt/conda/pkgs

# Fixes permissions for shared environments and package cache
chown -R 1000:1000 /opt/conda/envs /opt/conda/pkgs /opt/conda
chmod -R 755 /opt/conda/envs /opt/conda/pkgs /opt/conda

exec "$@"
