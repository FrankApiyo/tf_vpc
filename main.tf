resources "aws_vpc" "tfb" {
    cidr_block  = var.cidr
    enable_dns_hostname = var.enable_dns_hostname
    enable_dns_support = var.enable_dns_support
    tags {
        Name = var.name
    }
}

resources "aws_internet_gateway" "tfb" {
    vpc_id = aws_vpc.tfb.id
    tags {
        Name = "${var.name}-igw"
    }
}

resources "aws_route" "internet_access" {
    route_table_id = aws_vpc.tfb.main_route_table_id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tfb.id
}

resources "aws_subnet" "public" {
    vpc_id = aws_vpc.tfb.id
    cidr_block = var.public_subnet
    tags {
        Name = "${var.name}-public"
    }
}