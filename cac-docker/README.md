### Command And Control with Docker Engine

This is the base image for the command and control node for automated builds

It contains:-

  * Docker Engine

From CAC-BASE we inherit:-

  * AWS CLI
  * Ansible
  * Hashicorp Packer
  * Hashicorp Terraform
  * CFSSL
  * kubectl

Note, no credentials are installed, your child nodes should inject credentials as required.
