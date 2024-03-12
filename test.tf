data "aws_vpc" "ingress" {
    default = true
}

resource "aws_security_group" "ingress" {
    name        = "test"
    description = "Allow inbound"
    vpc_id      = data.aws_vpc.ingress.id
}

resource "aws_security_group_rule" "ingress" {
    type        = "ingress"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = var.public_cidr_block
    security_group_id = "${aws_security_group.ingress.id}"
}
