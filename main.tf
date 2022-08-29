data "aws_ssm_parameter" "ami_id" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "TF_Control" {
  ami                    = data.aws_ssm_parameter.ami_id.value
  instance_type          = "t3.small"
  vpc_security_group_ids = [aws_security_group.ssh.id]
  user_data              = fileexists("script.sh") ? file("script.sh") : null

  tags = {
    Name = "TF_Controller"
  }
}

# Some advanced output
output "ssh_port" {
  value       = "Terraform controller running on ${aws_instance.TF_Control.public_ip}"
  description = "Shows TF server is running"
}
