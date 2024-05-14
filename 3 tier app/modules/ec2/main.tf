# Create instance

resource "aws_instance" "ec2-instance" {
  ami           = var.ami_id
  key_name      = var.key_name
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_az1_id
  tags=  {
         Name = "My-EC2-Server"
  }
}