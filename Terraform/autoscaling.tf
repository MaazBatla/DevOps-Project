resource "aws_autoscaling_group" "app1_asg" {
  desired_capacity     = 1
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = module.vpc.public_subnets
  launch_template {
    id      = aws_launch_template.app1.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.app_target_group.arn]
}

resource "aws_autoscaling_group" "app2_asg" {
  desired_capacity     = 1
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = module.vpc.public_subnets
  launch_template {
    id      = aws_launch_template.app2.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.app_target_group.arn]
}

resource "aws_autoscaling_group" "bi_asg" {
  desired_capacity     = 1
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = module.vpc.public_subnets
  launch_template {
    id      = aws_launch_template.bi.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.bi_target_group.arn]
}