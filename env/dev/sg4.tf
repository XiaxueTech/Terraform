module "sg_4" {
  source = "../../modules/security-group"
  name                       = "SG4"
  description                = "description"
  vpc_id = data.aws_vpc.local_vpc.id
  ingress_rules              = [{"description": "ingress", "from_port": 0, "to_port": 0, "protocol": "-1", "cidr_block": ["0.0.0.0/0"]}]
  egress_rules               = [{"description": "egress", "from_port": 0, "to_port": 65535, "protocol": "TCP", "cidr_block": ["10.0.0.0/16"]}]
}

resource "aws_security_group" "example_sg" {
  name        = "example-sg"
  description = "Example security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
