resource "aws_security_group" "sg" {
  name        = "sg"
  description = "SG"
  vpc_id      = data.aws_vpc.local_vpc.id

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_security_group_rule" "out" {
  type              = "egress"
  description       = "Default public internet access"
  security_group_id = aws_security_group.sg.id
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
