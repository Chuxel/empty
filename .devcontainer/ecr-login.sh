#!/bin/bash

set +e

account_id_env_var=${1:-"ECR_ACCOUNT_ID"}
region_env_var=${1:-"ECR_REGION"}
access_key_id_env_var="${2:-"AWS_ACCESS_KEY_ID"}"
aws_secret_access_key_env_var="${3:-"AWS_SECRET_ACCESS_KEY"}"

tmp_root="$HOME/__aws-tmp"

rm -rf "${tmp_root}"
mkdir -p "${tmp_root}"

# Download aws CLI into temp spot if not found
if ! type aws > /dev/null 2>&1; then
    curl -sSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "${tmp_root}/awscliv2.zip"
    unzip "${tmp_root}/awscliv2.zip" -d "${tmp_root}"
    "${tmp_root}/aws/install" -i ${tmp_root}/aws-cli -b ${tmp_root}/bin
    export PATH="${PATH}:${tmp_root}/bin"
fi

# Login
export AWS_ACCESS_KEY_ID="${!access_key_id_env_var}"
export AWS_SECRET_ACCESS_KEY="${!aws_secret_access_key_env_var}"
#aws ecr get-login-password --region ${!region_env_var} | docker login --username AWS --password-stdin ${!account_id_env_var}.dkr.ecr.${!region_env_var}.amazonaws.com

touch "$(dirname $0)/ecr-login.sh.done"

# clean up
#rm -rf "${tmp_root}"
