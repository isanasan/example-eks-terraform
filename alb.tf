resource "aws_lb_target_group" "hoge_eks" {
  vpc_id = module.vpc.vpc_id

  connection_termination             = false
  ip_address_type                    = "ipv4"
  lambda_multi_value_headers_enabled = false
  load_balancing_algorithm_type      = "round_robin"
  load_balancing_cross_zone_enabled  = "use_load_balancer_configuration"
  name                               = "hoge-eks"
  port                               = 80
  protocol                           = "HTTP"
  protocol_version                   = "HTTP1"
  proxy_protocol_v2                  = false
  target_type                        = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  stickiness {
    cookie_duration = 86400
    enabled         = false
    type            = "lb_cookie"
  }
}

resource "aws_security_group" "hoge_eks_sg" {
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  ingress = [
    {
      cidr_blocks = [
        "119.25.132.221/32",
      ]
      description      = ""
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    },
  ]
  name   = "hoge-eks-sg"
  vpc_id = module.vpc.vpc_id
}

resource "aws_lb" "hoge_eks_lb" {
  name = "hoge-eks-lb"

  enable_cross_zone_load_balancing = true
  internal                         = false
  ip_address_type                  = "ipv4"
  security_groups = [
    "sg-017567c5b8b084ca7",
  ]
  subnets = [
    "subnet-031c1d5390cd4cf81",
    "subnet-0c76729945fd858a1",
  ]
  tags     = {}
  tags_all = {}

  subnet_mapping {
    subnet_id = "subnet-031c1d5390cd4cf81"
  }
  subnet_mapping {
    subnet_id = "subnet-0c76729945fd858a1"
  }
}
