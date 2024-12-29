#!/bin/zsh

source $(dirname $0)/.global.inc

export TF_HOME="$HOME"
export TF_CLI_ARGS="-var-file=envs/$AWS_INFRA_PF.tfvars"
export TF_CLI_ARGS_apply="-auto-approve"
export TF_VAR_ssh_user=$USER