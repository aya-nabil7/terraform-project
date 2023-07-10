resource "aws_instance" "public_instance" {
  ami                    = var.ami-id-pub-ins
  instance_type          = "t2.micro"
  subnet_id              = var.pub-ins-sub-id
  associate_public_ip_address = true
  key_name               = "ayanabil"
  tags = {
    Name = var.pub-ins-name
  }
  vpc_security_group_ids = [var.pub-ins-secg-id]

provisioner "local-exec" {
    command = "echo public-ip ${self.public_ip} >> all_ips.txt"
  }


user_data = <<-EOF
    #!/bin/bash

    # Update system packages
    sudo yum update -y

    # Install Nginx
    sudo yum install nginx -y

    # Configure Nginx as a proxy
    sudo tee /etc/nginx/conf.d/proxy.conf > /dev/null <<EOFC
    server {
        listen 80;
        server_name your_domain.com;

        location / {
            proxy_pass http://pro-priv-nlb-233866bfb5cfb3ac.elb.us-east-1.amazonaws.com;
            proxy_set_header Host \$host;
            proxy_set_header X-Real-IP \$remote_addr;
        }
    }
    EOFC

    # Restart Nginx
    sudo service nginx restart
  EOF

  }