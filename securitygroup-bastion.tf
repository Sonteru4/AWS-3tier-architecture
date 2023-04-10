resource "aws_security_group" "bastion_sg" {
  name        = "public-sg"
  description = "Allow SSH for bastion"
  vpc_id = module.vpc.vpc_id
  
  ingress {
    description      = "Allow port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] #This is a list item
    
  }

  egress {
    description = "Allow all ip and ports outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "VPC-3tier-ssh"
  }
}
