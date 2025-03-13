# this file is used to create ec2 instance on AWS 

# i did not use modules because you asked for only EC2 instance


provider "aws"{

    region = "us-east-1"

}

# i use a key from my machine for the 22 port part- ssh


// maybe i will get ssh key in the exam //
resource "aws_key_pair" "or_key" {
  key_name   = "or_key"
  public_key = file("C:/Users/orbit/.ssh/id_rsa.pub")  
}



resource "aws_security_group" "ec2_or_sg" {
  
    name = "Orsg"


# ingrees for ssh and http    
    ingress {

        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ] // maybe i will change it


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


resource "aws_instance" "or_builder" {

    ami = "ami-0e1bed4f06a3b463d"    ### i need to see if this is correct
    instance_type          = "t2.micro"
    key_name = aws_key_pair.or_key.key_name
    vpc_security_group_ids = [aws_security_group.ec2_or_sg.id]


    # in this part i try to Install and configure Docker and Docker Compose with my sqript
    user_data = <<-EOF
        #!/bin/bash
        sudo apt update -y
        sudo apt install -y docker.io docker-compose
        sudo systemctl enable docker
        sudo systemctl start docker
        sudo usermod -aG docker ubuntu
    EOF      

    tags ={

        Name="builder"
    }

}

output "instance_public_ip" {
  value = aws_instance.or_builder.public_ip
}












