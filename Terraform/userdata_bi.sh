#!/bin/bash

# Update and install necessary packages
sudo yum update -y
sudo yum install -y git docker curl
sudo amazon-linux-extras enable nginx1 -y
sudo amazon-linux-extras enable epel -y
sudo yum install -y epel-release
sudo yum install -y nginx python2-certbot-nginx

# Start and enable Docker and Nginx
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl enable nginx
sudo systemctl start nginx

# Add ec2-user to Docker group
sudo usermod -aG docker ec2-user

# Pull and run Metabase on port 3000
sudo docker pull metabase/metabase
sudo docker run -d -p 3000:3000 --name metabase metabase/metabase

# Nginx reverse proxy configuration
cat <<EOF | sudo tee /etc/nginx/conf.d/metabase.conf
server {
    listen 80;
    server_name maaz-bi.devopsagent.online;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

# Reload Nginx and request SSL certificate
sudo nginx -t && sudo systemctl reload nginx

# sudo certbot --nginx -d maaz-bi.devopsagent.online