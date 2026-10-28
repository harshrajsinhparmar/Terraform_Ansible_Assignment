output "web_server_public_ip" {
  description = "Public IP of the TravelMemory web server"
  value       = aws_instance.web.public_ip
}

output "web_server_private_ip" {
  description = "Private IP of the web server"
  value       = aws_instance.web.private_ip
}

output "db_server_private_ip" {
  description = "Private IP of the MongoDB server"
  value       = aws_instance.db.private_ip
}

output "nat_gateway_public_ip" {
  description = "Elastic IP attached to the NAT Gateway"
  value       = aws_eip.nat.public_ip
}

output "vpc_id" {
  description = "Created VPC ID"
  value       = aws_vpc.main.id
}

output "app_url" {
  description = "TravelMemory application URL"
  value       = "http://${aws_instance.web.public_ip}"
}

output "ssh_web" {
  description = "SSH command for the web server"
  value       = "ssh -i ${var.private_key_path} ubuntu@${aws_instance.web.public_ip}"
}

output "ssh_db_via_bastion" {
  description = "SSH command for the private DB server through the web server"
  value       = "ssh -i ${var.private_key_path} -J ubuntu@${aws_instance.web.public_ip} ubuntu@${aws_instance.db.private_ip}"
}