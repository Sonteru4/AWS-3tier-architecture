module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.5.0"

  name = "3tier-alb"

  load_balancer_type = "application"

  vpc_id             = module.vpc.vpc_id
  subnets            = [module.vpc.public_subnets[0],module.vpc.public_subnets[1]]
  security_groups    = [aws_security_group.private_sg.id]

  #Listener

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

#Target Group

target_groups = [
    # App1 Target Group
    {
      name_prefix      = "app1-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }      
      protocol_version = "HTTP1"
      # App1 Target Group - Targets
      targets = {
        my_app1_vm1 = {
          target_id = module.ec2_private[0].id
          port      = 80
        },
        my_app1_vm2 = {
          target_id = module.ec2_private[1].id
          port      = 80
        }        
      }
   }
  ]
tags = {
        Name= "3tier-alb"
    } 
}
