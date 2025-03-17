# this is the part i made for making an ssh key and use it to connect to the ec2 instance
# i use this in builder.tf file
# most of this code is what from you gave in the example

# Generate an SSH key pair
resource "tls_private_key" "or_builder_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# Save the private key locally
resource "local_file" "or_builder_private_key" {
  content         = tls_private_key.or_builder_ssh_key.private_key_pem
  filename        = "${path.module}/.ssh/or_builder_key.pem"
  file_permission = "0600" 
}
# Create an AWS key pair using the public key
resource "aws_key_pair" "or_builder_key_pair" {
  key_name   = "or-builder-key"
  public_key = tls_private_key.or_builder_ssh_key.public_key_openssh
}
# Output the necessary details
output "or_builder_ssh_private_key_path" {
  value       = local_file.or_builder_private_key.filename
  description = "Path to the generated private SSH key"
  sensitive   = true
}
# another output for the key name
output "or_builder_ssh_key_name" {
  value       = aws_key_pair.or_builder_key_pair.key_name
  description = "Name of the AWS SSH key pair"
}
