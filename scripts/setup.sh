#!/bin/bash

set -euo pipefail

TERRAFORM_VERSION=0.13.7

if [ "$(uname)" == "Darwin" ]; then
    OSTYPE=darwin
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    OSTYPE=linux
fi

#install terraform
wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_${OSTYPE}_amd64.zip
unzip -q /tmp/terraform.zip -d /tmp
chmod +x /tmp/terraform
mv /tmp/terraform /usr/local/bin
rm /tmp/terraform.zip
terraform --version
