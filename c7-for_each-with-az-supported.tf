#get the list of az in a specific region .
data "aws_availability_zones" "myzones" {
    filter {
        name = "opt-in-status"
        values = ["opt-in-not-required"]
    }
}
#chec the rtespective instance type is supported in that specific region 
data "aws_ec2_instance_type_offerings" "my_inst_typ" {
    for_each = toset(data.aws_availability_zones.myzones.names)
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }

  filter {
    name   = "location"
    values = [each.key]
  }

  location_type = "availability-zone-id"
}

#output1
#search for all az mapped to supported instance
output "output_v3_1" {
    value = {
    for az, details in data.aws_ec2_instance_type_offerings.my_inst_typ: az => details.instance_types
    }
}

#search for all az not supported instance type
output "output_v3_2" {
    value = {
    for az, details in data.aws_ec2_instance_type_offerings.my_inst_typ: az => details.instance_types if length(details.instance_types)!=0
    }
}

