ARG ubuntu_ver=20.04

FROM entrypoint:local AS entrydata
FROM ubuntu:${ubuntu_ver}
LABEL description="Ubuntu, passwordless sudo, and SSH user via ENV."

ARG user_uid=1000
ARG user_gid=1000
ARG TZ=America/Bogota

ARG docker_app=true

USER root
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=${TZ}

ENV USER_UID=${user_uid}
ENV USER_GID=${user_gid}

RUN apt-get update -y && apt-get install -y --no-install-recommends \
     sudo curl wget git openssh-server && rm -rf /var/lib/apt/lists/*


# SSH
RUN mkdir -p /var/run/sshd
RUN ssh-keygen -A
RUN sed -i 's/^#PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config \
     && sed -i 's/^#PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config

# Docker
RUN if [ "$docker_app" = "true" ]; then \
    apt-get update && \
    apt-get install -y \
        ca-certificates \
        gnupg \
        lsb-release \
        software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io && \
    docker --version && \
    apt-get clean && rm -rf /var/lib/apt/lists/*; \
else \
    echo "Docker installation skipped."; \
fi

# Start custom system
COPY start.sh /usr/start.sh
COPY --from=entrydata /entrypoint/create-user.sh /usr/create-user.sh
COPY --from=entrydata /entrypoint/docker-start.sh /usr/docker-start.sh

RUN chmod +x /usr/start.sh /usr/create-user.sh /usr/docker-start.sh

ENTRYPOINT [ "/usr/start.sh" ]

CMD ["/usr/sbin/sshd", "-D"]