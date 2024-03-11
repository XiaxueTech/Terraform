data "aws_vpc" "vpc" {
    default = true
}

resource "aws_security_group" "ingress" {
    name        = "test"
    description = "Allow inbound"
    vpc_id      = data.aws_vpc.ingress.id
}

resource "aws_security_group" "egress" {
    name        = "test"
    description = "Allow outbound"
    vpc_id      = data.aws_vpc.vpc.id
}

resource "aws_security_group_rule" "ingress" {
    type        = "ingress"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.ingress.id}"
}

resource "aws_security_group_rule" "egress" {
    type        = "egress"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.egress.id}"
}
