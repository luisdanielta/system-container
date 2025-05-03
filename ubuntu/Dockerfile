FROM ubuntu:20.04
LABEL description="Ubuntu with Miniconda, passwordless sudo, and SSH user via ENV."

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Bogota

# Expose Conda in PATH
ENV PATH=/opt/conda/bin:$PATH

# Install dependencies
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      sudo curl wget openssh-server \
 && rm -rf /var/lib/apt/lists/*

# Create user, set its password, grant sudo
ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=1000

COPY entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

COPY password.txt /password.txt

EXPOSE 22

ENTRYPOINT ["/tmp/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]