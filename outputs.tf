output "nginx_public_dns" {
  value = "${aws_instance.nginx-server.public_dns}"
}

output "nginx_instance_id" {
  value = "${aws_instance.nginx-server.id}"
}

output "key_pair_name" {
  value = "${aws_key_pair.instance-key-pair.key_name}"
}

output "security_group_id" {
  value = "${aws_security_group.instance-security-group.id}"
}
