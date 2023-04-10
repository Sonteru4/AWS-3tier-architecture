module "ec2_private" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  
  depends_on = [module.vpc]
  name = "Application-${count.index}"

  count = 2
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = "t2.micro"
  key_name               = "my-acc"
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  subnet_id            = element(module.vpc.private_subnets, count.index)

  user_data = file("${path.module}/userdata.sh")
  tags = {
    Name = "3tier-application-servers"
  }
}
