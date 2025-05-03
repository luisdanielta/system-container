#!/bin/sh
set -e

# Copies conda configuration to the expected location
cp -a /tmp/.condarc /opt/conda

# Fixes permissions for shared environments and package cache
chmod -R 777 /opt/conda/envs
mkdir -p /opt/conda/pkgs
chmod -R 777 /opt/conda/pkgs

exec "$@"
