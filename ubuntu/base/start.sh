#!/usr/bin/env bash
set -e

/usr/create-user.sh

BASHRC="/home/${USERNAME}"
if [ ! -f "$BASHRC/.bashrc" ]; then
    cp /etc/skel/.bashrc "$BASHRC/.bashrc"
fi

if ! grep -Fq "# >>> bash >>>" "$BASHRC/.bash_profile"; then
    cat << 'EOF' >> "$BASHRC/.bash_profile"
# >>> bash >>>
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
# <<< bash <<<
EOF
fi

. "$BASHRC/.bash_profile"

# Execute your custom initialization scripts
if [ "$DOCKER_APP" = "true" ]; then
    /usr/docker-start.sh
fi

/usr/shh-start.sh
exec "$@"