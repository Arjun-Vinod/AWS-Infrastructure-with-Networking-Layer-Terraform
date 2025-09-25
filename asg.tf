data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
resource "aws_launch_template" "app_launch_template" {
  name_prefix   = "aws-project-launch-template"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "aws-project-app-instance"
    }
  }
}
resource "aws_autoscaling_group" "app_asg" {
  name                = "aws-project-asg"
  vpc_zone_identifier = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  health_check_type   = "ELB"
  min_size  = 1
  max_size  = 3
  desired_capacity = 2
  target_group_arns   = [aws_lb_target_group.app_tg.arn]
  
  launch_template {
    id      = aws_launch_template.app_launch_template.id
    version = "$Latest"
  }

  tag {
    key = "Name"
    value = "aws-project-asg-instance"
    propagate_at_launch = true
  }
}