resource "aws_lb_target_group_attachment" "reg" {
  target_group_arn = var.re-tg
  target_id        = var.re-inst-id
  port             = 80
}



