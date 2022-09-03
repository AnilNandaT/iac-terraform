
#Create db subnet group
resource "aws_docdb_subnet_group" "prepaire-db-subnet-group" {
  name       = "prepaire-${var.environment}-db-subnet-group"
  subnet_ids = [aws_subnet.prepaire-db-1a.id, aws_subnet.prepaire-db-1b.id]

  tags = {
    Name      = "prepaire-${var.environment}-db-subnet-group"
    Terraform = "true"
  }
}

#Document DB creation
resource "aws_docdb_cluster" "prepaire-db" {
  cluster_identifier              = "prepaire-${var.environment}-db"
  engine                          = "docdb"
  master_username                 = "AzureDiamondUsername"
  master_password                 = "hrj3289d2pbIQ9N"
  backup_retention_period         = 5
  preferred_backup_window         = "07:00-09:00"
  skip_final_snapshot             = true
  db_subnet_group_name            = aws_docdb_subnet_group.prepaire-db-subnet-group.id
  deletion_protection             = true
  kms_key_id                      = aws_kms_key.aws-db-kms-key.arn
  vpc_security_group_ids          = [aws_security_group.prepaire-db-sg.id]
  enabled_cloudwatch_logs_exports = ["audit", "profiler"]
  storage_encrypted               = true
  tags = {
    Name      = "prepaire-${var.environment}-db"
    Terraform = "true"
  }
}

resource "aws_docdb_cluster_instance" "prepaire-db-instance" {
  count              = 1
  identifier         = "prepaire-${var.environment}-db-${count.index}"
  cluster_identifier = aws_docdb_cluster.prepaire-db.id
  instance_class     = "db.t4g.medium"
}


#Neptune database

# resource "aws_neptune_cluster" "drug-search" {
#   cluster_identifier                  = "prepaire-${var.environment}-drug-search"
#   engine                              = "neptune"
#   backup_retention_period             = 5
#   preferred_backup_window             = "05:20-05:50"
#   skip_final_snapshot                 = true
#   iam_database_authentication_enabled = false
#   apply_immediately                   = true
#   kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/868e9902-dfc4-4f06-ae5c-d05fb3116180"
#   neptune_subnet_group_name = aws_docdb_subnet_group.prepaire-db-subnet-group.id
#   deletion_protection             = true
#   enable_cloudwatch_logs_exports = ["audit"]
#   storage_encrypted = true
#   vpc_security_group_ids = [aws_security_group.prepaire-neptune-db-sg.id]
#   tags = {
#     Name      = "prepaire-${var.environment}-drug-search"
#     Terraform = "true"
#   }
# }

# resource "aws_neptune_cluster_instance" "drug-search" {
#   count              = 1
#   cluster_identifier = "prepaire-${var.environment}-drug-search-${count.index}"
#   engine             = "neptune"
#   instance_class     = "db.t3.medium"
#   apply_immediately  = true
# }