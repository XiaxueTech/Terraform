resource "aws_security_group" "egress" {
    name        = "test2"
    description = "Allow outbound"
    vpc_id      = data.aws_vpc.egress.id
}

resource "aws_security_group_rule" "egress" {
    type        = "egress"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = var.public_cidr_block
    security_group_id = "${aws_security_group.egress.id}"
}
