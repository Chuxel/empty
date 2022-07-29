# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.238.1/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version (use ubuntu-22.04 or ubuntu-18.04 on local arm64/Apple Silicon): ubuntu-22.04, ubuntu-20.04, ubuntu-18.04
ARG VARIANT="jammy"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# Install kind
RUN curl -sSLf https://kind.sigs.k8s.io/dl/v0.14.0/kind-linux-$(dpkg --print-architecture) -o /usr/local/bin/kind \
    && chmod +x /usr/local/bin/kind 

