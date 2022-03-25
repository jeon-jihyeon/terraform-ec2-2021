# security group for alb
resource "aws_security_group" "alb" {
  name   = "${var.environment}-sg-alb"
  vpc_id = var.vpc_id

  ingress {
    protocol         = "tcp"
    from_port        = 80
    to_port          = 80
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    protocol         = "tcp"
    from_port        = 443
    to_port          = 443
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.environment}-sg-alb"
    Environment = var.environment
  }
}


// Basiton Host
resource "aws_security_group" "bastion" {
  name        = "${var.environment}-sg-bastion"
  description = "Security group for bastion instance"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 22 
    to_port     = 22
    cidr_blocks = [var.office_cidr]
  }  

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = var.private_subnets
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = var.private_subnets
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-sg-bastion"
    Environment = var.environment
  }
}

resource "aws_security_group" "backend" {
  name        = "${var.environment}-sg-backend"
  description = "Security group for backend instance"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
    security_groups = [aws_security_group.alb.id]
  }

  ingress {
    protocol        = "tcp"
    from_port       = 22 
    to_port         = 22
    security_groups = [aws_security_group.bastion.id]
  }  

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.environment}-sg-backend"
    Environment = var.environment
  }
}

resource "aws_security_group" "rds" {
  name            = "${var.environment}-sg-rds"
  description     = "RDS Allowed Ports"
  vpc_id          = var.vpc_id

  ingress {
    protocol          = "tcp"
    from_port         = var.database_port
    to_port           = var.database_port
    security_groups   = [aws_security_group.backend.id]
  }

  ingress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"
    cidr_blocks   = [ "0.0.0.0/0" ]
  } 

  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"
    cidr_blocks   = [ "0.0.0.0/0" ]
  } 

  tags = {
    Name        = "${var.environment}-sg-rds"
    Environment = var.environment
  }
}

