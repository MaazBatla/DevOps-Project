resource "aws_lb_target_group" "app_target_group" {
  name     = "app-target-group"
  port     = 3000                     # App container listens on port 3000
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "3000"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

# Attach app1 EC2 to the target group
resource "aws_lb_target_group_attachment" "app1_attachment" {
  target_group_arn = aws_lb_target_group.app_target_group.arn
  target_id        = aws_instance.app1.id
  port             = 3000
}

# Attach app2 EC2 to the target group
resource "aws_lb_target_group_attachment" "app2_attachment" {
  target_group_arn = aws_lb_target_group.app_target_group.arn
  target_id        = aws_instance.app2.id
  port             = 3000
}