provider "aws" {
    region="ap-south-1"
    access_key= "AKIA4RU6WBHZOPWFMEJY"
    secret_key="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"

}

variable "subnet_cidr_block" {
    description= "subnet cidr block"
    default = "10.0.10.0/20"
    type = string

}

variable "vpc_cidr_block" {
    description= "vpc cidr block"

}

variable avail_zone {}
resource "aws_vpc" "dev-vpc" {
    cidr_block=var.vpc_cidr_block
    tags= {
        Name: "Development"
    }
}

resource "aws_subnet" "subnet-1" {
    vpc_id = aws_vpc.dev-vpc.id
    cidr_block= var.subnet_cidr_block
    availability_zone=var.avail_zone
    tags= {
        Name: "subnet-1-dev"
    }

}

data "aws_vpc" "existing_vpc" {
    default= true
}

resource "aws_subnet" "subnet-2" {
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block= "172.31.48.0/20"
    availability_zone="ap-south-1b"
    tags={
        Name: "subnet-1-default"
    }

}


output "dev-vpc-id" {
    value=aws_vpc.dev-vpc.id
}

output "dev-subnet-id" {
    value=aws_subnet.subnet-1.id
}