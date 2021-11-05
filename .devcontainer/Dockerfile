ARG VARIANT
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# Install openvpn client
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update \
    && apt-get -y install --no-install-recommends openvpn \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/library-scripts
