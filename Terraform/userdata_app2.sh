#!/bin/bash

# Update and install necessary packages
sudo yum update -y
sudo yum install -y git docker curl
sudo amazon-linux-extras enable nginx1 -y
sudo amazon-linux-extras enable epel -y
sudo yum install -y epel-release
sudo yum install -y nginx python2-certbot-nginx

# Enable and start Docker and Nginx
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl enable nginx
sudo systemctl start nginx

# Add ec2-user to Docker group
sudo usermod -aG docker ec2-user

# Clone the React application
cd /home/ec2-user
git clone https://github.com/Khhafeez47/reactapp.git
cd reactapp
chown -R ec2-user:ec2-user .

# Create a multi-stage Dockerfile
cat <<'EOF' > Dockerfile
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

# Build and run the container on port 3000
sudo docker build -t reactapp .
sudo docker run -d -p 3000:80 reactapp

# Nginx reverse proxy configuration
cat <<EOF | sudo tee /etc/nginx/conf.d/reactapp.conf
server {
    listen 80;
    server_name maaz-app-2.devopsagent.online;

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

# Test and reload Nginx
sudo nginx -t && sudo systemctl reload nginx

# SSL with Let's Encrypt
# sudo certbot --nginx -d maaz-app-2.devopsagent.online