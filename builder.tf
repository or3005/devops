# this file is used to create ec2 instance on AWS 

# i did not use modules because you asked for only EC2 instance and keyes

# genrate keys are in a diffrent tf file that included in git

provider "aws"{

    region = "us-east-1"

}


# new serach for public subnet (from the vpc grented)
data "aws_subnets" "or_public_subnets" {
  filter {
    name   = "vpc-id"
    values = ["vpc-044604d0bfb707142"]
  }
}


# create a security group for the ec2 instance
resource "aws_security_group" "ec2_or_sg" {
  
    name = "Orsg"
    vpc_id = "vpc-044604d0bfb707142"

# ingrees for ssh and http    
    ingress {

        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ] 


    }

    ingress {
        from_port = 5001
        to_port = 5001
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }




# egrees for all of the trafic (out to the internet)
    egress  {
       from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]  
    }

    tags={
        Name="Orsg"
    }

}

# create the ec2 instance
resource "aws_instance" "or_builder" {

    ami = "ami-0e1bed4f06a3b463d"    ### i need to see if this is correct
    instance_type          = "t3.medium"
    subnet_id              = data.aws_subnets.or_public_subnets.ids[0] 
    # here is the key that i created in the ssh_keys.tf file
    key_name               = aws_key_pair.or_builder_key_pair.key_name 
    vpc_security_group_ids = [aws_security_group.ec2_or_sg.id]
    associate_public_ip_address = true 

    # in this part i try to Install and configure Docker and Docker Compose with my sqript on the ec2 instance
    user_data = <<-EOF
        #!/bin/bash
        sudo apt update -y
        sudo apt install -y docker.io docker-compose
        sudo systemctl enable docker
        sudo systemctl start docker
        sudo usermod -aG docker ubuntu
        sudo reboot
    EOF      

    tags ={

        Name="ORbuilder"
    }

}

# public ip of the ec2 output
output "instance_public_ip" {
  value       = aws_instance.or_builder.public_ip
  description = "Public IP of the EC2 instance"
}


# security group output as asked in the exam
output "security_group_id" {
  value       = aws_security_group.ec2_or_sg.id
  description = "Security Group ID"
}
# this is the output of the key as asked in the exam
output "ssh_key_name" {
  value       = aws_key_pair.or_builder_key_pair.key_name
  description = "SSH Key Name"
}

