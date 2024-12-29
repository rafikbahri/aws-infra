#!/bin/zsh

source $(dirname $0)/.global.inc

export SSH_INIT_USER=ec2-user
export ANSIBLE_INVENTORY="inventory/$AWS_INFRA_PF"
