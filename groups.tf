# SG for http:8080
resource "aws_security_group" "ssh" {
  name = "terraform-SG-ssh"

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

