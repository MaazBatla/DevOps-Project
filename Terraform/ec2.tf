resource "aws_launch_template" "app1" {
  name_prefix   = "app1-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = filebase64("${path.module}/userdata_app1.sh")

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "app1-instance"
    }
  }
}

resource "aws_launch_template" "app2" {
  name_prefix   = "app2-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = filebase64("${path.module}/userdata_app2.sh")

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "app2-instance"
    }
  }
}

resource "aws_launch_template" "bi" {
  name_prefix   = "bi-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = filebase64("${path.module}/userdata_bi.sh")

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "bi-instance"
    }
  }
}