output "public_ip" {
  value = azurerm_public_ip.pip.ip_address
}

output "port" {
  value = var.port
}

output "token" {
  value = data.local_file.jupyter_server_token.content
}
