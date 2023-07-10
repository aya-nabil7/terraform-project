#private EC2 instance
resource "aws_instance" "priv-apache-ec2" {
  ami                    = var.ami-id  
  instance_type          = "t2.micro"
  subnet_id              = var.sub-ins-id
  associate_public_ip_address = false
  key_name               = "ayanabil" 
  tags = {
    Name = var.name-ins
  }
vpc_security_group_ids = [var.segID]

provisioner "local-exec" {
command = "echo private-ip ${self.private_ip} >> all-ips.txt"

}

  


  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
    echo "Welcome to private EC2 instance in a private subnet .. ^-^ I'm aya nabil ." | sudo tee /var/www/html/index.html
    sudo systemctl restart httpd
  EOF
}
