resource "aws_lb_target_group" "nodejs_tg" {
  name     = "nodejs-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.network.vpc_id 
}


resource "aws_lb_target_group_attachment" "nodejs_tg_attach" {
  target_group_arn = aws_lb_target_group.nodejs_tg.arn
  
  target_id        = aws_instance.app.id 
  port             = 80
}
