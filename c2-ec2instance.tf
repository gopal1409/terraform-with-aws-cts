#aws will look for all the data center in a particular region. az
#once it find that i have multiple az i need to do iteration. same environment i need to deploy in every region
resource "aws_instance" "name" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  user_data = file ("${path.module}/app1-install.sh")
  #key_name = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id,aws_security_group.vpc-web.id]
  #to do the same i am using for_each loop
  for_each = toset(keys({for az, details in data.aws_ec2_instance_type_offerings.my_inst_typ: az => details.instance_type if length(details.instance_types)!=0}))
  availability_zone = each.key
  #i have use toset bcz for_each loop required 
  #availability_zone = each.key #here i am passing az as each.key but this toset(inside to set whatever you put it will convert it into each.key we)
  #we didint use each.value but we can use it as to set also convert each.key == each.value
  
  tags = {
      "Name" = "for_each_demo-${each.value}"
  }
}