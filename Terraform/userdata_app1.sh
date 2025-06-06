#!/bin/bash

# Update and install packages
sudo yum update -y
sudo yum install -y git docker curl
sudo amazon-linux-extras enable nginx1
sudo yum install -y nginx python3-certbot-nginx

# Enable and start services
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl enable nginx
sudo systemctl start nginx

# Add ec2-user to docker group
sudo usermod -aG docker ec2-user

# Clone React App
cd /home/ec2-user
sudo git clone https://github.com/Khhafeez47/reactapp.git
sudo chown -R ec2-user:ec2-user reactapp
cd reactapp

# Write Dockerfile inside project directory
cat <<EOF | sudo tee Dockerfile
# Stage 1: Build React App
FROM node:20 AS build
WORKDIR /app
COPY . .
RUN npm install && npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
EOF

# Build and run the container
sudo docker build -t reactapp .
sudo docker run -d -p 80:80 reactapp

# Nginx reverse proxy config on EC2
cat <<CONF | sudo tee /etc/nginx/conf.d/reactapp.conf
server {
    listen 80;
    server_name maaz-app-1.devopsagent.online;

    location / {
        proxy_pass http://127.0.0.1:80;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
CONF

# Restart Nginx and set up SSL
sudo nginx -t && sudo systemctl reload nginx
sudo certbot --nginx -d maaz-app-1.devopsagent.online --non-interactive --agree-tos -m maazarsalan@outlook.com --redirect