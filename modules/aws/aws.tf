resource "aws_key_pair" "key" {
  key_name   = var.key_name
  public_key = file(var.ssh_key)
}

resource "aws_security_group" "grafana_webserver" {
    name = "grafana_webserver"
    description = "Securty group for Webserver instance"

  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "grafana_webserver_instance" {
    instance_type     = var.instance_type
    ami               = var.ami_id
    key_name          = var.key_name
    security_groups   = ["${aws_security_group.grafana_webserver.name}"]
    user_data         = file(var.grafana)

    tags = {
        name = "grafana_webserver_instance"
    }
}