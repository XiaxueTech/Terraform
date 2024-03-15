data "aws_vpc" "local_vpc" {
    default = true
}

data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.local_vpc.id]
  }

  tags = {
    Type = "Private"
  }
}