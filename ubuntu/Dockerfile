ARG ubuntu_ver=20.04

FROM entrypoint:local AS entrydata
FROM ubuntu:${ubuntu_ver}
LABEL description="Ubuntu, passwordless sudo, and SSH user via ENV."

ARG user_uid=1000
ARG user_gid=1000
ARG TZ=America/Bogota

ARG docker_app=true
ARG app_essentials=true

USER root
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=${TZ}
EXPOSE 22

ENV USER_UID=${user_uid}
ENV USER_GID=${user_gid}

RUN apt-get update -y && apt-get install -y --no-install-recommends \
    sudo openssh-server && rm -rf /var/lib/apt/lists/*

# App essentials
RUN if [ "$app_essentials" = "true" ]; then \
    apt-get update && apt-get install -y build-essential curl nano git wget \
    && apt-get clean && rm -rf /var/lib/apt/lists/*; \
    echo "App essentials installed."; \
    else \
    echo "App essentials installation skipped."; \
    fi

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
COPY --from=entrydata /entrypoint/shh-start.sh /usr/shh-start.sh
COPY --from=entrydata /entrypoint/docker-start.sh /usr/docker-start.sh

RUN chmod +x /usr/start.sh /usr/create-user.sh /usr/shh-start.sh /usr/docker-start.sh

ENTRYPOINT [ "/usr/start.sh" ]