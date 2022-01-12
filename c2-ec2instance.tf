resource "aws_instance" "name" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  user_data = file ("${path.module}/app1-install.sh")
  #key_name = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id,aws_security_group.vpc-web.id]
  tags = {
      "Name" = "Ec2-Demo"
  }
}