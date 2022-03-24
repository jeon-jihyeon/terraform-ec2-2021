resource "aws_db_subnet_group" "rds_subnet" {
  name                   = "${var.environment}-rds-subnet"
  description            = "RDS subnet group"
  subnet_ids             = var.private_subnet_ids
}

# rds pg
resource "aws_db_parameter_group" "rds_default" {
  name = "${var.name}-rds-pg-${var.environment}"
  description = "The Parameter group for rds"
  family = var.rds_pg_family

#  parameter {
#    name  = "character_set_server"
#    value = "utf8"
#  }

#  parameter {
#    name  = "character_set_client"
#    value = "utf8"
#  }

#  parameter {
#    name = "autocommit"
#    value = 0
#  }

#  parameter {
#    name = "time_zone"
#    value = "Asia/Seoul"
#  }

  tags = {
    Name        = "${var.name}-mysql-pg"
    Environment = var.environment
  }
}

data "aws_db_instance" "recent_rds" {
  db_instance_identifier = var.recent_rds_name
}

resource "aws_db_snapshot" "rds_snapshot" {
  db_instance_identifier = data.aws_db_instance.recent_rds.id
  db_snapshot_identifier = "${var.recent_rds_name}-snapshot"
}

resource "aws_db_instance" "rds_instance" {
  identifier             = "${var.environment}-rds"
  allocated_storage      = var.rds_allocated_storage
  max_allocated_storage  = var.rds_max_storage
  engine                 = var.rds_engine
  engine_version         = var.rds_engine_version
  instance_class         = var.rds_instance_class
  name                   = var.database_name
  username               = var.database_user
  password               = var.database_password
  vpc_security_group_ids = var.rds_security_group_ids
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet.name
  parameter_group_name   = aws_db_parameter_group.rds_default.name
  storage_type           = var.rds_storage_type
  storage_encrypted      = false
  skip_final_snapshot    = true
  publicly_accessible    = true
  multi_az               = var.environment != "dev" ? true : false
  snapshot_identifier    = data.aws_db_snapshot.rds_snapshot.id

  lifecycle {
      ignore_changes = [
        "snapshot_identifier",
      ]
  }

  tags = {
    Name        = "${var.environment}-rds"
    Environment = var.environment
  }
}
