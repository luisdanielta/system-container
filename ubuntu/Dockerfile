FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=America/Bogota \
    USERNAME=user \
    USER_UID=1000 \
    USER_GID=1000 \
    USER_PASSWORD=user_password \
    PATH="/opt/conda/bin:$PATH"

# 1. Instala dependencias y sshd
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      sudo curl git unzip wget nano \
      openssh-server && \
    rm -rf /var/lib/apt/lists/*

# 2. Prepara directorio de sshd
RUN mkdir -p /var/run/sshd

# 3. Copia y da permisos al entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# 4. Arranca siempre por entrypoint; el CMD se ignora al usar sshd en foreground
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
