resource "aws_instance" "bi" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  key_name                    = var.key_name
  user_data                   = file("${path.module}/userdata_bi.sh")
  associate_public_ip_address = true

  tags = {
    Name = "bi-instance"
  }
}