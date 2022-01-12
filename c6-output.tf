output "instance_public_ip" {
  value = toset([for instance in aws_instance.name: instance.public_ip])
}

output "instance_public_dns" {
  value = toset([for instance in aws_instance.name: instance.public_dns])
}