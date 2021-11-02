# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.202.5/containers/debian/.devcontainer/base.Dockerfile

# [Choice] Debian version (use bullseye or stretch on local arm64/Apple Silicon): bullseye, buster, stretch
ARG VARIANT="buster"
#FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}
FROM 711005317894.dkr.ecr.us-east-2.amazonaws.com/vscode/devcontainers/base:0-${VARIANT}

# Install AWS CLI
RUN export tmp_root="/tmp/__aws-tmp" \
    && curl -sSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "${tmp_root}/awscliv2.zip" \
    && unzip "${tmp_root}/awscliv2.zip" -d "${tmp_root}" > /dev/null \
    && ${tmp_root}/aws/install \
    && rm -rf ${tmp_root}

# ** [Optional] Uncomment this section to install additional packages. **
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

