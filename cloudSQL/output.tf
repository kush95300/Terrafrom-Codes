output "mysql_db_private_ip" {
  value = google_sql_database_instance.master.private_ip_address
}

output "read_replica_private_ip" {
  value = google_sql_database_instance.read_replica.*.private_ip_address
  
}
  