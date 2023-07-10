#target group
resource "aws_lb_target_group" "tg" {
  name = var.tg-name
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.nlb-vpc-id
  target_type = "instance"
  health_check {
    enabled = true
    path    = "/"
  }
}
