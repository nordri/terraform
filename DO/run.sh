#!/bin/bash -x
set -eu

source credentials

if [ "$1" != "plan" ] && [ "$1" != "apply" ]; then
  echo "$0 [ plan | apply ]"
  exit 1
fi

terraform $1 \
  -var "do_token=${DO_PAT}" \
  -var "pub_key=$HOME/.ssh/id_ecdsa.pub" \
  -var "pvt_key=$HOME/.ssh/id_ecdsa" \
  -var "ssh_fingerprint=${DO_SSH_FINGERPRINT}"

terraform show terraform.tfstate