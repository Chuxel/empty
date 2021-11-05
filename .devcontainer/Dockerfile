# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.203.0/containers/debian/.devcontainer/base.Dockerfile

# [Choice] Debian version (use bullseye or stretch on local arm64/Apple Silicon): bullseye, buster, stretch
ARG VARIANT="buster"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

COPY openvpn-debian.sh /tmp/library-scripts/
RUN bash /tmp/library-scripts/openvpn-debian.sh \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/library-scripts

#ENTRYPOINT ["/usr/local/share/dbus-init.sh"]
ENTRYPOINT ["/usr/local/share/network-manager-init.sh"]
CMD ["sleep", "infinity"]
