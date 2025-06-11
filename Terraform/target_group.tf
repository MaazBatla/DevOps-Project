resource "aws_lb_target_group" "app1_tg" {
  name     = "app1-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    path     = "/"
    protocol = "HTTP"
    port     = "3000"
    matcher  = "200"
  }
}

resource "aws_lb_target_group" "app2_tg" {
  name     = "app2-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    path     = "/"
    protocol = "HTTP"
    port     = "3000"
    matcher  = "200"
  }
}

resource "aws_lb_target_group" "bi_tg" {
  name     = "bi-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    path     = "/"
    protocol = "HTTP"
    port     = "3000"
    matcher  = "200"
  }
}