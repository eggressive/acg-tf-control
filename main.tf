resource "tls_private_key" "this" {
  algorithm = "RSA"
}

module "key_pair" {
  source = "./modules/terraform-aws-key-pair"

  key_name           = "TFkeypair"
  create_private_key = true
}

data "aws_ssm_parameter" "ami_id" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "TF_Control" {
  ami                    = data.aws_ssm_parameter.ami_id.value
  instance_type          = "t3.small"
  vpc_security_group_ids = [aws_security_group.ssh.id]
  key_name               = "TFkeypair"
  user_data              = fileexists("script.sh") ? file("script.sh") : null

  tags = {
    Name = "TF_Controller"
  }
}

output "ssh_port" {
  value       = "Terraform controller running on ${aws_instance.TF_Control.public_ip}"
  description = "Shows TF server is running"
}

output "private_key_pem" {
  description = "Private key data in PEM (RFC 1421) format"
  value       = tls_private_key.this.private_key_pem
  sensitive   = true
}