resource "aws_security_group" "private_sg" {
  name        = "private_sg"
  description = "private security group"
  vpc_id      = module.vpc.vpc.id

  dynamic "ingress" {               # its a dynamic ingress ( incoming traffic)
    for_each = [22, 80, 443]        # for_each loop
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {            # outgoing traffic
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "private_sg"
  }

}
