# bastion EC2
resource "aws_key_pair" "bastion" {
  key_name   = "${var.environment}-bastion-ssh-key"
  public_key = var.ssh_pub_key
}

data "aws_ami" "amazon_linux_nat" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "bastion" {
  count                  = length(var.public_subnet_ids)
  instance_type          = var.instance_type
  ami                    = data.aws_ami.amazon_linux_nat.id
  availability_zone      = element(var.availability_zones, count.index)
  subnet_id              = element(var.public_subnet_ids, count.index)  
  vpc_security_group_ids = var.bastion_security_group_ids
  key_name               = aws_key_pair.bastion.key_name

  associate_public_ip_address = true
  source_dest_check           = false

  tags = {
    Name        = "${var.environment}-bastion-${format("%03d", count.index+1)}"
    Environment = var.environment
  }
}

# bastion EIP
resource "aws_eip" "bastion" {
 count    = length(var.public_subnet_ids)
 vpc      = true
 instance = element(aws_instance.bastion.*.id, count.index)
}