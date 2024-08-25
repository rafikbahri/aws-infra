#!/bin/bash

export TF_HOME="$HOME"
export TF_CLI_ARGS="-var-file=envs/$AWS_INFRA_PLATFORM.tfvars"
export TF_CLI_ARGS_apply="-auto-approve"
export TF_VAR_ssh_user=$USER
