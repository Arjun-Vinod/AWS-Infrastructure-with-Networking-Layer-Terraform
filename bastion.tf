resource "aws_instance" "bastion" {
  ami                    = "ami-0360c520857e3138f"
  instance_type          = "t2.micro"
  key_name              = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  subnet_id             = aws_subnet.public_subnet_1.id
  tags = {
    Name = "aws-project-bastion"
  }
}