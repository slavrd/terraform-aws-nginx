provider "aws" {
  access_key              = "${var.access_key}"
  secret_key              = "${var.secret_key}"
  shared_credentials_file = "${var.aws_cred_file_path}"
  region                  = "${var.region}"
}

resource "aws_key_pair" "instance-key-pair" {
  key_name_prefix = "tf-nginx-"
  public_key      = "${file("${var.pub_key_instance_path}")}"
}

resource "aws_security_group" "instance-security-group" {
  name_prefix = "tf-nginx-"

  ingress = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress = {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress = {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = "true"
  }

  egress = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nginx-server" {
  ami                    = "${var.nginx_ami_id}"
  instance_type          = "${var.instance_type}"
  key_name               = "${aws_key_pair.instance-key-pair.key_name}"
  vpc_security_group_ids = ["${aws_security_group.instance-security-group.id}"]
}
