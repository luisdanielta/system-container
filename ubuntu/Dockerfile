ARG ubuntu_ver=20.04

FROM entrypoint:local AS entrydata
FROM ubuntu:${ubuntu_ver}
LABEL description="Ubuntu, passwordless sudo, and SSH user via ENV."

ARG user_uid=1000
ARG user_gid=1000
ARG TZ=America/Bogota

USER root
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=${TZ}

ENV USER_UID=${user_uid}
ENV USER_GID=${user_gid}

RUN apt-get update -y && apt-get install -y --no-install-recommends \
     sudo curl wget git openssh-server && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd
RUN ssh-keygen -A
RUN sed -i 's/^#PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config \
     && sed -i 's/^#PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config

COPY --from=entrydata /entrypoint/create-user.sh /usr/create-user.sh
RUN chmod +x /usr/create-user.sh
ENTRYPOINT ["/usr/create-user.sh"]

CMD ["/usr/sbin/sshd", "-D"]