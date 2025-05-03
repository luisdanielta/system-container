FROM ubuntu:20.04

USER root
ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=1000

RUN apt-get update && \
    apt-get install -y sudo passwd && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd --gid ${USER_GID} ${USERNAME} && \
    useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME} && \
    echo "${USERNAME}   soft   nproc   unlimited" >> /etc/security/limits.conf

RUN sed -i 's/^.*pam_rootok.so$/auth       sufficient pam_rootok.so/' /etc/pam.d/su && \
    sed -i 's/^#auth\s*required\s*pam_wheel.so$/auth       sufficient pam_wheel.so trust group=wheel/' /etc/pam.d/su && \
    groupadd wheel && usermod -aG wheel ${USERNAME}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    git \
    unzip nano \
    wget && \
    rm -rf /var/lib/apt/lists/*

USER ${USERNAME}
WORKDIR /home/${USERNAME}

ENV PATH=/opt/conda/bin:$PATH

CMD ["bash"]