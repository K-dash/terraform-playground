# primary
output "primary_address" {
    value = module.mysql_primary.address
    description = "Connect to the primary database at this endpoint"
}

output "primary_port" {
    value = module.mysql_primary.port
    description = "The port to access the primary database on"
}

output "primary_arn" {
    value = module.mysql_primary.arn
    description = "The ARN of the primary database"
}

# replica
output "replica_address" {
    value = module.mysql_replica.address
    description = "Connect to the replica database at this endpoint"
}

output "replica_port" {
    value = module.mysql_replica.port
    description = "The port to access the replica database on"
}

output "replica_arn" {
    value = module.mysql_replica.arn
    description = "The ARN of the replica database"
}
