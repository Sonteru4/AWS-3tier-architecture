module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "BastionHost"
 
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = "t2.micro"
  key_name               = "my-acc"
 
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Name = "Bastion-3 tier"
  }
}
