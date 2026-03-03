# Creation of EC2 Instance
resource "aws_security_group" "tf_security_grp" {
  name        = "Main Security Group"
  description = "Terraform generated security group"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "Main Security Group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_http_rule_default" {
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  security_group_id = aws_security_group.tf_security_grp.id
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "ingress_ssh_rule_default" {
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  security_group_id = aws_security_group.tf_security_grp.id
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "egress_rule_default" {
  ip_protocol       = "-1"
  security_group_id = aws_security_group.tf_security_grp.id
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name

  subnet_id = aws_subnet.main_public_subnet_a.id

  user_data = file("scripts/httpd_init.sh")

  security_groups = [aws_security_group.tf_security_grp.id]

  tags = {
    "Name" = "Web Server"
  }
}
