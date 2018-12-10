# Terraform AWS EC2 Nginx

A terraform project to deploy a Nginx server in AWS and Kitchen-CI tests with Kitchen-Terraform.

## Prerequisites

### Install terraform

[Terraform installation instructions](https://www.terraform.io/intro/getting-started/install.html#installing-terraform)

### Set up rbenv - instructions for MAC

It is recommended to use rbenv or another Ruby versions manager.

* Install rbenv - run `brew install rbenv`
* Initialize rbenv - add to `~/.bash_profile` line `eval "$(rbenv init -)"`
* Run `source ~/.bash_profile`
* Install ruby 2.3.1 with rbenv - run `rbenv install 2.3.1` , check `rbenv versions`
* Set ruby version for the project to 2.3.1 - run `rbenv local 2.3.1` , check `rbenv local`

### Install Ruby gems - needed for Kitchen-CI

* Install bundler - run `gem install bundler`
* Install gems from Gemfile - run `bundle install`

### Nginx AWS ami

Choose or create an AWS ami with nginx. [This](https://github.com/slavrd/packer-aws-nginx64) is an example project for creating such ami with packer.

## Creating/Managing the infrastructure

### Set up Terraform variables

[Instructions](https://learn.hashicorp.com/terraform/getting-started/variables.html#assigning-variables) on how to set variables in Terraform

#### Credentials setup

You can set-up AWS access in any of the following ways:

* set credentials in `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables
* use shared credentials file by setting its path in `aws_cred_file_path` terraform variable
* set the credentials in the terraform variables `access_key` and `secret_key`

#### Required Terraform variables

* `region` - set the AWS region to work in
* `pub_key_instance_path` - set path to the file containing the public key from which to create the EC2 key pair.
* `instance_type` - set the EC2 instance type

### Run Terraform

* Initialize the project's directory - run `terraform init`
* Create/update infrastructure - run `terraform apply`
* Destroy - run `terraform destroy`

## Running Kitchen-CI tests

### Set up kitchen

In .kitchen.yml set the path to the file containing the private kye of the EC2 key pair.

```YAML
key_files:
  - path/to/AWS/key-pair/private/key
```

### Run Kitchen tests

* List kitchen environment - `bundle exec kitchen list`
* Build kitchen environment - `bundle exec kitchen converge`
* Run kitchen tests - `bundle exec kitchen verify`
* Destroy kitchen environment - `bundle exec kitchen destroy`
* Automatically build, test, destroy - `bundle exec kitchen test`