#!/bin/bash
apt-get update
apt-get install -y --no-install-recommends pass gnupg2 pinentry-tty
curl -sSL https://github.com/microsoft/Git-Credential-Manager-Core/releases/download/v2.0.474/gcmcore-linux_amd64.2.0.474.41365.deb -o /tmp/gcm.deb
dpkg -i /tmp/gcm.deb
rm -f /tmp/gcm.deb

echo "export GPG_TTY=\$(tty)" >> /etc/bash.bashrc
echo "export GPG_TTY=$TTY" >> /etc/zsh/zshrc

