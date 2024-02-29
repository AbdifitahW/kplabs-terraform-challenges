variable "instance_config" {
  type = map
  // AMI Ids invalid for us-east-1 region 
  default = {
    instance1 = { instance_type = "t2.micro", ami = "ami-03a6eaae9938c858c" }
    instance2 = { instance_type = "t2.small", ami = "ami-053b0d53c279acc90" }
  }
}

resource "aws_instance" "instance" {
 for_each = var.instance_config 

 ami = each.value.ami
 instance_type = each.value.ami
}