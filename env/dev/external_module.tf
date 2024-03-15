module "label" {
  source = "cloudposse/label/null"
  # Cloud Posse recommends pinning every module to a specific version
  # version = "x.x.x"
  namespace  = "eg"
  stage      = "prod"
  name       = "bastion"
  attributes = ["public"]
  delimiter  = "-"

  tags = {
    "BusinessUnit" = "XYZ",
    "Snapshot"     = "true"
  }
}

module "vpc" {
  source = "cloudposse/vpc/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version = "x.x.x"
  cidr_block = "10.0.0.0/16"

  context = module.label.context
}

module "sg" {
  source = "cloudposse/security-group/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version = "x.x.x"

  # Security Group names must be unique within a VPC.
  # This module follows Cloud Posse naming conventions and generates the name
  # based on the inputs to the null-label module, which means you cannot
  # reuse the label as-is for more than one security group in the VPC.
  #
  # Here we add an attribute to give the security group a unique name.
  attributes = ["primary"]

  # Allow unlimited egress
  allow_all_egress = true

  rules = [
    {
      key         = "ssh"
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self        = null  # preferable to self = false
      description = "Allow SSH from anywhere"
    },
    {
      key         = "HTTP"
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = []
      self        = true
      description = "Allow HTTP from inside the security group"
    }
  ]

  vpc_id  = module.vpc.vpc_id

  context = module.label.context
}

module "sg_mysql" {
  source = "cloudposse/security-group/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version = "x.x.x"

  # Add an attribute to give the Security Group a unique name
  attributes = ["mysql"]

  # Allow unlimited egress
  allow_all_egress = true

  rule_matrix =[
    # Allow any of these security groups or the specified prefixes to access MySQL
    {
      source_security_group_ids = [var.dev_sg, var.uat_sg, var.staging_sg]
      prefix_list_ids = [var.mysql_client_prefix_list_id]
      rules = [
        {
          key         = "mysql"
          type        = "ingress"
          from_port   = 3306
          to_port     = 3306
          protocol    = "tcp"
          description = "Allow MySQL access from trusted security groups"
        }
      ]
    }
  ]

  vpc_id  = module.vpc.vpc_id

  context = module.label.context
}
