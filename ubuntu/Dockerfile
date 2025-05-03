FROM ubuntu:20.04

USER root
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Bogota

ARG username=user
ARG USER_UID=1000
ARG USER_GID=1000

RUN apt-get update && \
    apt-get install -y sudo passwd && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd --gid ${USER_GID} ${username} && \
    useradd --uid ${USER_UID} --gid ${USER_GID} -m ${username} && \
    echo "${username} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${username} && \
    chmod 0440 /etc/sudoers.d/${username} && \
    echo "${username}   soft   nproc   unlimited" >> /etc/security/limits.conf

RUN sed -i 's/^.*pam_rootok.so$/auth       sufficient pam_rootok.so/' /etc/pam.d/su && \
    sed -i 's/^#auth\s*required\s*pam_wheel.so$/auth       sufficient pam_wheel.so trust group=wheel/' /etc/pam.d/su && \
    groupadd wheel && usermod -aG wheel ${username}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    git \
    unzip nano \
    wget && \
    rm -rf /var/lib/apt/lists/*

USER ${username}
WORKDIR /home/${username}

ENV PATH="/opt/conda/bin:$PATH"

CMD ["bash"]