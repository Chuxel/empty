# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.203.0/containers/codespaces-linux/.devcontainer/base.Dockerfile

FROM mcr.microsoft.com/vscode/devcontainers/universal:1-focal

RUN sudo az extension add --source https://azdevcliextstorage.blob.core.windows.net/whls/azure_dev-0.0.1-py2.py3-none-any.whl -y --system

# ** [Optional] Uncomment this section to install additional packages. **
# USER root
#
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>
#
# USER codespace
