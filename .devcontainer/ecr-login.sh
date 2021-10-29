#!/bin/bash

set -e

account_id_env_var=${1:-"ECR_ACCOUNT_ID"}
region_env_var=${1:-"ECR_REGION"}
access_key_id_env_var="${2:-"AWS_ACCESS_KEY_ID"}"
aws_secret_access_key_env_var="${3:-"AWS_SECRET_ACCESS_KEY"}"

rm -rf /tmp/aws-tmp/*
mkdir -p /tmp/aws-tmp

# Download aws CLI into temp spot if not found
if ! type aws > /dev/null 2>&1; then
    mkdir -p /tmp/aws-tmp/bin 
    curl -sSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip -d /tmp/aws-tmp
    rm -f awscliv2.zip
    /tmp/aws-tmp/aws/install -i /tmp/aws-tmp/aws-cli -b /tmp/aws-tmp/bin
    export PATH="${PATH}:/tmp/aws-tmp/bin"
fi

registry_ids_part=""
if [ "${registry_ids}" != "" ]; then
    registry_ids_part="--registry-ids ${registry_ids}"
fi

# Login
export AWS_ACCESS_KEY_ID="${!access_key_id_env_var}"
export AWS_SECRET_ACCESS_KEY="${!aws_secret_access_key_env_var}"
aws ecr get-login-password \
    --region ${!region_env_var} \
| docker login \
    --username AWS \
    --password-stdin ${!account_id_env_var}.dkr.ecr.${!region_env_var}.amazonaws.com

# clean up
#rm -rf /tmp/aws-tmp
