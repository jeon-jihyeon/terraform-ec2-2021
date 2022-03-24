variable "name" {
  description = "the name of your stack, e.g. \"demo\""
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
}

variable "rds_pg_family" {
  description = "The family of the DB parameter group"
}

variable "rds_allocated_storage" {
  description = "Amount of storage to be initially allocated for the DB instance, in gigabytes."
}

variable "rds_max_storage" {
  description = "Amount of storage to be initially allocated for the DB instance, in gigabytes."
}

variable "rds_engine" {
  description = "Name of the database engine to be used for this instance."
}

variable "rds_engine_version" {
  description = "Version number of the database engine to use."
}

variable "rds_instance_class" {
  description = "The compute and memory capacity of the instance"
}

variable "rds_storage_type" {
  description = "Specifies the storage type for the DB instance."
}

variable "rds_security_group_ids" {
  description = "The security group id for rds"
}

variable "database_name" {
  description = "The name of the database."
}

variable "database_user" {
  description = "The name of the master database user."
}

variable "database_password" {
  description = "Password for the master DB instance user"
}

variable "private_subnet_ids" {
  description = "List of Private subnet id"
}

variable "recent_rds_name" {
  description = "RDS name of recent version"
}