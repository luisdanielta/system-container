FROM ubuntu:20.04

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server curl ca-certificates \
  && mkdir /var/run/sshd

RUN useradd -m -s /bin/bash vscode \
  && echo 'vscode ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir -p /home/vscode/.vscode-server/bin/latest \
  && curl -fsSL "https://update.code.visualstudio.com/latest/server-linux-x64/stable" \
     | tar -xz --strip-components=1 -C /home/vscode/.vscode-server/bin/latest \
  && touch /home/vscode/.vscode-server/bin/latest/0

# 4. Exponer SSH y arrancar
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]