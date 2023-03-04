# アカウントIDの取得
data "aws_caller_identity" "current" {}
locals {
  account_id = "${data.aws_caller_identity.current.account_id}"
}

# 自分のパブリックIP取得
data "http" "workstation-external-ip" {
  url = "http://ipv4.icanhazip.com/"
}
locals {
  myip = chomp(data.http.workstation-external-ip.response_body)
}
locals {
  allowed_cidr = (var.allowed_cidr == null) ? "${local.myip}/32" : var.allowed_cidr
}


# ---------------------------
# VPC
# ---------------------------
resource "aws_vpc" "main"{
  cidr_block                       = "10.0.0.0/16"
  enable_dns_hostnames             = "true"
  enable_dns_support               = "true"
  tags = {
    Name = "${var.app_name}-${var.environment}-vpc"
  }

  tags_all = {
    Name = "${var.app_name}-${var.environment}-vpc"
  }
}

# ---------------------------
# Subnet
# ---------------------------
resource "aws_subnet" "public-a" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = "10.0.1.0/24"
  availability_zone   = "${var.az_a}"
  tags = {
    Name = "${var.app_name}-${var.environment}-public-subnet-a"
  }
  tags_all = {
    Name = "${var.app_name}-${var.environment}-public-subnet-a"
  }
}

resource "aws_subnet" "public-c" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = "10.0.2.0/24"
  availability_zone   = "${var.az_c}"
  tags = {
    Name = "${var.app_name}-${var.environment}-public-subnet-c"
  }
  tags_all = {
    Name = "${var.app_name}-${var.environment}-public-subnet-c"
  }

}


resource "aws_subnet" "private-a" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = "10.0.10.0/24"
  availability_zone   = "${var.az_a}"
  tags = {
    Name = "${var.app_name}-${var.environment}-private-subnet-a"
  }
  tags_all = {
    Name = "${var.app_name}-${var.environment}-private-subnet-a"
  }
}

resource "aws_subnet" "private-c" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = "10.0.11.0/24"
  availability_zone   = "${var.az_c}"
  tags = {
    Name = "${var.app_name}-${var.environment}-private-subnet-c"
  }
  tags_all = {
    Name = "${var.app_name}-${var.environment}-private-subnet-c"
  }
}


# ---------------------------
# Internet Gateway
# ---------------------------
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.app_name}-${var.environment}-igw"
  }
  tags_all = {
    Name = "${var.app_name}-${var.environment}-igw"
  }

}



# ---------------------------
# Route table
# ---------------------------
# Route table作成
resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "${var.app_name}-${var.environment}-public-rtb"
  }
  tags_all = {
    Name = "${var.app_name}-${var.environment}-public-rtb"
  }
}
# resource "aws_route_table" "private-rtb" {
#   vpc_id = aws_vpc.main.id
#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.main.id
#   }
#   tags = {
#     Name = "${var.app_name}-${var.environment}-private-rtb"
#   }
#   tags_all = {
#     Name = "${var.app_name}-${var.environment}-private-rtb"
#   }
# }




# SubnetとRoute tableの関連付け
resource "aws_route_table_association" "public-a-rtb-associate" {
  subnet_id = aws_subnet.public-a.id
  route_table_id = aws_route_table.public-rtb.id
}
resource "aws_route_table_association" "public-c-rtb-associate" {
  subnet_id = aws_subnet.public-c.id
  route_table_id = aws_route_table.public-rtb.id
}
# resource "aws_route_table_association" "private-a-rtb-associate" {
#   subnet_id = aws_subnet.private-a.id
#   route_table_id = aws_route_table.private-rtb.id
# }
# resource "aws_route_table_association" "private-c-rtb-associate" {
#   subnet_id = aws_subnet.private-c.id
#   route_table_id = aws_route_table.private-rtb.id
# }




# ---------------------------
# Security Group
# ---------------------------
# Security Group作成
resource "aws_security_group" "http" {
  vpc_id      = aws_vpc.main.id
  name        = "${var.app_name}-${var.environment}-http-sg"
  description = "For ${var.environment} HTTP"

  # アウトバウンドルール
  egress {
    cidr_blocks      = ["0.0.0.0/0"]
    from_port        = "0"
    ipv6_cidr_blocks = ["::/0"]
    protocol         = "-1"
    self             = "false"
    to_port          = "0"
  }

  # インバウンドルール
  ingress {
    cidr_blocks      = ["0.0.0.0/0"]
    from_port        = "80"
    ipv6_cidr_blocks = ["::/0"]
    protocol         = "tcp"
    self             = "false"
    to_port          = "80"
  }
  # インバウンドルール
  ingress {
    cidr_blocks = ["0.0.0.0/0", "10.0.0.0/16"]
    from_port   = "8080"
    protocol    = "tcp"
    self        = "false"
    to_port     = "8080"
  }

  tags = {
    Name = "${var.app_name}-${var.environment}-http-sg"
  }

  tags_all = {
    Name = "${var.app_name}-${var.environment}-http-sg"
  }
}

resource "aws_security_group" "https" {
  vpc_id      = aws_vpc.main.id
  name        = "${var.app_name}-${var.environment}-https-sg"
  description = "For ${var.environment} HTTPS"

  # アウトバウンドルール
  egress {
    cidr_blocks      = ["0.0.0.0/0"]
    from_port        = "0"
    ipv6_cidr_blocks = ["::/0"]
    protocol         = "-1"
    self             = "false"
    to_port          = "0"
  }
  # インバウンドルール
  ingress {
    cidr_blocks      = ["0.0.0.0/0"]
    from_port        = "443"
    ipv6_cidr_blocks = ["::/0"]
    protocol         = "tcp"
    self             = "false"
    to_port          = "443"
  }
  tags = {
    Name = "${var.app_name}-${var.environment}-https-sg"
  }
  tags_all = {
    Name = "${var.app_name}-${var.environment}-https-sg"
  }
}


resource "aws_security_group" "rds" {
  vpc_id                 = aws_vpc.main.id
  name                   = "${var.app_name}-${var.environment}-rds-sg"
  description            = "For ${var.environment} RDS(MySQL)"

  # アウトバウンドルール
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  # インバウンドルール
  ingress {
    cidr_blocks     = [local.allowed_cidr]
    from_port       = "3306"
    protocol        = "tcp"
    security_groups = [aws_security_group.http.id, aws_security_group.https.id]
    self            = "false"
    to_port         = "3306"
  }
  tags = {
    Name = "${var.app_name}-${var.environment}-rds-sg"
  }
  tags_all = {
    Name = "${var.app_name}-${var.environment}-rds-sg"
  }
}
