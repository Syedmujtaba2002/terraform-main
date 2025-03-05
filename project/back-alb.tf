resource "aws_lb" "back_alb" {
  name               = "back-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_all.id]
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id]

  tags = {
    Name = "backend-alb"
  }
}

resource "aws_lb_target_group" "back_tg" {
  name     = "back-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.three_tier_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "back_listener" {
  load_balancer_arn = aws_lb.back_alb.arn
  port               = 80
  protocol           = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.back_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "be_tg_attachment" {
  target_group_arn = aws_lb_target_group.back_tg.arn
  target_id        = aws_instance.backend.id
  port             = 80
}

