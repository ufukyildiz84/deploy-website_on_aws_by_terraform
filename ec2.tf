# Use data source to retrieve an Amazon Linux 2 AMI
data "aws_ami" "latest_linux_ami" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["al2023-ami-2023*x86_64"]
  }
}


# launch ec2 instance and install your website
resource "aws_instance" "ec2_instance" {
  ami                         = data.aws_ami.latest_linux_ami.id
  instance_type               = "t2.micro"
  availability_zone           = "us-west-2a"
  associate_public_ip_address = true
  key_name                    = "vockey"
  vpc_security_group_ids      = [aws_security_group.webserver_security_group.id]
  subnet_id                   = aws_subnet.public_subnet_az1.id
  count                       = 1
  user_data                   = file("userdata.tpl")

  tags = {
    Name = "web-instance"
  }
}
