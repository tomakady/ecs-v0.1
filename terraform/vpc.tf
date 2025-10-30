#VPC
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
      name = "main-vpc"
    }
}

# Internet Gateway

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
      name = "main-igw"
    }
}

# Elastic IP for NAT Gateway

resource "aws_eip" "nat_eip" {
    domain = "vpc"

    tags = {
      name = "nat-eip"
    }
}

# Public Subnets

resource "aws_subnet" "public_1" {
    vpc_id = aws_vpc.main.id
    cidr_block = ""
    availability_zone = "eu-west-2a"

    tags = {
      name = "public-subnet-1"
    }
}

resource "aws_subnet" "public_2" {
    vpc_id = aws_vpc.main.id
    cidr_block = ""
    availability_zone = "eu-west-2b"

    tags = {
      name = "public-subnet-2"
    }
}

# Private Subnets

resource "aws_subnet" "private_1" {
    vpc_id = aws_vpc.main.id
    cidr_block = ""
    availability_zone = "eu-west-2a"

    tags = {
      name = "private-subnet-1"
    }
}

resource "aws_subnet" "private_2" {
    vpc_id = aws_vpc.main.id
    cidr_block = ""
    availability_zone = "eu-west-2b"

    tags = {
      name = "private-subnet-2"
    }
}

# NAT Gateway

resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public_1.id

    tags = {
      name = "nat-gateway"
    }

    depends_on = [aws_internet_gateway.igw]
}

# Public Route Table

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main.id

    route = {
        cidr_block = "0.0.0.0/0"
    }

    tags = {
      name = "public-rt"
    }
}

# Private Route Table

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.main.id

    route = {
        cidr_block = "0.0.0.0/0"
    }

    tags = {
      name = "private-rt"
    }

}

# Public Subnet Route Table Associations

resource "aws_route_table_association" "public_1_assoc" {
    subnet_id = aws_subnet.public_1.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_2_assoc" {
    subnet_id = aws_subnet.public_2.id
    route_table_id = aws_route_table.public_rt.id
}

# Private Subnet Route Table Associations

resource "aws_route_table_association" "private_1_assoc" {
    subnet_id = aws_subnet.private_1.id
    route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_2_assoc" {
    subnet_id = aws_subnet.private_2.id
    route_table_id = aws_route_table.private_rt.id
}