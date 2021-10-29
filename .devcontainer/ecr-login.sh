#!/bin/bash

access_key_id_env_var="${1:-"AWS_ACCESS_KEY_ID"}"
aws_secret_access_key_env_var="${1:-"AWS_SECRET_ACCESS_KEY"}"
registry_ids=${1:-${ECR_REGISTRY_IDS:-"none"}}

mkdir -p /tmp/aws-tmp

# Download aws CLI into temp spot if not found
if ! type aws > /dev/null 2>&1; then
    mkdir -p /tmp/aws-tmp/bin 
    curl -sSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip -d /tmp/aws-tmp
    /tmp/aws-tmp/install -i /tmp/aws-tmp/aws-cli -b /tmp/aws-tmp/bin
    export PATH="${PATH}:/tmp/aws-tmp/bin"
fi

registry_ids_part=""
if [ "${registry_ids}" != "none" ]; then
    registry_ids_part="--registry-ids ${registry_ids}"
fi

# Emit temporary config profile
cat << EOF > /tmp/aws-tmp/config-profile
[default]
aws_access_key_id=${!access_key_id_env_var}
aws_secret_access_key=${!aws_secret_access_key_env_var}
EOF

# Login
eval "$(aws ecr get-login ${registry_ids_part} --profile /tmp/aws-tmp/config-profile)"

# clean up
rm -rf /tmp/aws-tmp
