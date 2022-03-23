resource "aws_iam_role" "backend" {
  name = "${var.environment}-backend-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = {
      Name = "${var.environment}-backend-role"
  }
}

resource "aws_iam_instance_profile" "backend" {
  name = "${var.environment}-backend-profile"
  role = aws_iam_role.backend.name
}

resource "aws_key_pair" "backend" {
  key_name   = "${var.environment}-backend-keypair"
  public_key = var.ssh_pub_key
}

# backend instance
resource "aws_instance" "backend" {
  count                  = length(var.private_subnet_ids)
  instance_type          = var.instance_type
  ami                    = var.ami
  availability_zone      = element(var.availability_zones, count.index)
  subnet_id              = element(var.private_subnet_ids, count.index)
  vpc_security_group_ids = var.backend_security_group_ids
  key_name               = aws_key_pair.backend.key_name
  iam_instance_profile   = aws_iam_instance_profile.backend.name

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "30"
    delete_on_termination = true
  }
#  associate_public_ip_address = var.environment == "dev" ? true : false

  tags = {
    Name        = "${var.environment}-backend-${format("%03d", count.index+1)}"
    Environment = var.environment
  }
}

# bastion EIP
resource "aws_eip" "backend" {
  count    = length(var.private_subnet_ids)
  vpc      = true
  instance = element(aws_instance.backend.*.id, count.index)
}


