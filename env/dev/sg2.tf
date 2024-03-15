module "sg_2" {
  source = "../../modules/security-group"
  name                       = "SG2"
  description                = "description"
  vpc_id = data.aws_vpc.local_vpc.id
  ingress_rules              = [{"description": "ingress", "from_port": 0, "to_port": 0, "protocol": "-1", "cidr_block": ["0.0.0.0/0"]}]
  egress_rules               = [{"description": "egress", "from_port": 443, "to_port": 65535, "protocol": "TCP", "cidr_block": ["172.16.0.0/12"]}]
}
