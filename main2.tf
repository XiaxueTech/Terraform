resource "aws_security_group" "egress2" {
    name        = "test22"
    description = "Allow outbound"
    vpc_id      = data.aws_vpc.egress2.id
}

resource "aws_security_group_rule" "egress2" {
    type        = "egress"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = var.public_cidr_block
    security_group_id = "${aws_security_group.egress2.id}"
}
