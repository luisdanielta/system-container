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

# Execute your custom initialization scripts
/usr/docker-start.sh
/usr/shh-start.sh

. "$BASHRC/.bash_profile"
exec "$@"