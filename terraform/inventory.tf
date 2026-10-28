resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/inventory/hosts.ini"

  content = templatefile("${path.module}/templates/hosts.ini.tftpl", {
    web_public_ip    = aws_instance.web.public_ip
    web_private_ip   = aws_instance.web.private_ip
    db_private_ip    = aws_instance.db.private_ip
    private_key_path = var.private_key_path
    ssh_allowed_cidr = var.ssh_allowed_cidr
    vpc_cidr         = var.vpc_cidr
  })

  file_permission = "0600"
}