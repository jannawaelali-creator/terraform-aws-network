resource "aws_lb" "nodejs_alb" {
  name               = "nodejs-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-SG.id]
  subnets            = [module.network.subnets["public_subnet_1"].id, module.network.subnets["public_subnet_2"].id] 
}


resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.nodejs_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nodejs_tg.arn
  }
}


output "alb_dns_name" {
  value       = aws_lb.nodejs_alb.dns_name
  description = "The public URL of your Application Load Balancer"
}