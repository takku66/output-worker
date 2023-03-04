resource "aws_vpc" "sample-terraform-cloud-vpc"{
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "sample-terraform-cloud-vpc"
    }
}