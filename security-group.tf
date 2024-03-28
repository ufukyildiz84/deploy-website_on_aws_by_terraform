# create security group for the web server
# terraform aws create security group
resource "aws_security_group" "webserver_security_group" {
  name        = "website-group"
  description = "enable http/https access on port 80 and access on port 22 via ssh sg"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress {
    description      = "http access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.cidr_block]
  }

 
  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.cidr_block]
  }

 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = [var.cidr_block]
  }

  tags   = {
    Name = "sg-vpc"
  }
}

#create security group for rds db instance
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "permit access from web security group"
  vpc_id      =  aws_vpc.dev_vpc.id
ingress {
  from_port       = 3306
  to_port         = 3306
  protocol        = "tcp"
  security_groups = [aws_security_group.webserver_security_group.id]
}
egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
tags = {
  Name = "rds_sg"
}
}

