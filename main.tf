# Configure the AWS Provider
provider "aws" {
  region     = "eu-west-2"
}

variable "cidr_block" {
    description= "cidr block for vpc and subnet"
    type = list(object({
        cidr_block = string
        name = string
    }))

}

variable "avail_zone" {}

resource "aws_vpc" "development_vpc" {
  cidr_block = var.cidr_block[0].cidr_block
  tags = {
    Name = var.cidr_block[0].name
  }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.development_vpc.id
    cidr_block = var.cidr_block[1].cidr_block
    availability_zone = var.avail_zone
    tags = {
        Name = var.cidr_block[1].name
    }
}

output "dev-vpc-id" {
    value = aws_vpc.development_vpc.id
  
}

output "dev-subnet-id" {
    value = aws_subnet.dev-subnet-1.id
  
}
