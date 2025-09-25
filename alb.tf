resource "aws_lb" "app_alb" {
  name = "aws-project-alb"
  internal  = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb_sg.id]
  subnets  = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  enable_deletion_protection = false
  tags = {
    Name = "aws-project-alb"
  }
}
resource "aws_lb_target_group" "app_tg" {
  name = "aws-project-tg"
  port = 8000
  protocol = "HTTP"
  vpc_id = aws_vpc.aws_project.id

  health_check {
    enabled   = true
    healthy_threshold = 2
    interval = 30
    matcher = "200"
    path = "/"
    port = "traffic-port"
    protocol = "HTTP"
    timeout = 5
    unhealthy_threshold = 2
  }
  tags = {
    Name = "aws-project-tg"
  }
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}