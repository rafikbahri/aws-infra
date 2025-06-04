AWS Infra
=========

Overview
--------

This repo contains custom Terraform modules to build AWS infrastructure (EC2, subnet,...).

To SSH into the instance after a `jobs/deploy`.

```sh
ssh -F .ssh/config -i ~/.ssh/id_ed25519_bastion ec2-user@bastion001
```

TODOs
-----

### Project

-

### Features

- Bastions with ASG
