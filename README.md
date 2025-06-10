# 🚀 DevOps Final Project: Scalable, Secure, Containerized AWS Infrastructure

## 📌 Objective

The goal of this project is to provision a **scalable**, **secure**, and **containerized** cloud infrastructure using **Terraform**, **Docker**, and **AWS services**, and deploy a full-stack application along with a Business Intelligence (BI) tool.

---

## 🧱 Architecture Overview

- **Auto Scaling EC2 Instances** (3) running Nginx, Docker, Node.js 20
- **RDS MySQL & PostgreSQL** in private subnets with secure access via SSH tunneling
- **Application Load Balancer (ALB)** with HTTP and HTTPS support
- **Multi-stage Dockerized Full-Stack Application** (Frontend + Backend)
- **BI Tool** (Metabase) deployed via Docker and connected to RDS
- **Route53 Domain and SSL** using AWS ACM
- **Live Dashboard** to demonstrate real-time DB updates

---

## 🗂️ Terraform File Structure

```bash
.
├── main.tf                  # VPC and provider setup
├── ec2.tf                   # Launch Template & Auto Scaling Group
├── rds.tf                   # RDS MySQL and PostgreSQL instances
├── alb.tf                   # Application Load Balancer
├── route53.tf               # Route53 records and domain setup
├── target_group.tf          # ALB Target Groups
├── security_groups.tf       # All SGs for EC2, ALB, and RDS
├── outputs.tf               # Export outputs like ALB DNS
├── variables.tf             # Variables used across .tf files
├── terraform.tfvars         # Values for declared variables
├── userdata_app1.sh         # User data for app instance 1
├── userdata_app2.sh         # User data for app instance 2
├── userdata_bi.sh           # User data for BI instance
├── modules/
│   └── vpc/                 # Optional VPC module for reusability
└── .terraform/              # Terraform state and lock files
```
---

## 🚀 EC2 Auto Scaling Setup

- Used **Launch Template** with Amazon Linux 2 AMI.
- Installed **Nginx**, **Docker**, and **Node.js 20** via custom **User Data Scripts**.
- Created an **Auto Scaling Group (ASG)** with a desired capacity of 3 EC2 instances.
- Deployed two application containers (frontend and backend) across 2 instances.
- Deployed a BI tool container on the third instance.

---

## 🛢️ RDS Instances

- Provisioned two **RDS Instances**:
  - One with **MySQL**
  - One with **PostgreSQL**
- Both instances were placed in **private subnets**, inaccessible from the internet.
- Configured **Security Groups** to allow access **only from EC2** within the VPC.
- Used **SSH tunneling** to securely access the database from a local SQL client.
- Inserted dummy tables and records to validate the setup.

---

## 🌐 Application Load Balancer (ALB)

- Configured an **Application Load Balancer** (ALB) with:
  - **HTTP (port 80)** listener redirecting to HTTPS
  - **HTTPS (port 443)** listener forwarding to application target groups
- Integrated **ACM SSL Certificate** for encrypted communication.
- ALB directs traffic to the Dockerized application on EC2 instances via **Target Groups**.

---

## 🐳 Dockerized Application Deployment

- Application code is hosted in this [**public GitHub repository**](https://github.com/Khhafeez47/reactapp).
- Each EC2 instance clones the repo and runs a **Dockerized multi-stage build** via `UserData`.
- Application stack includes:
  - React
  - Docker
- Logs are outputted to standard Docker logs for debugging.

### Sample Dockerfile (multi-stage):

```dockerfile
# Stage 1: Builder
FROM node:20 AS builder
WORKDIR /app
COPY . .
RUN npm install && npm run build

# Stage 2: Runner
FROM node:20
WORKDIR /app
COPY --from=builder /app/dist ./dist
CMD ["node", "dist/index.js"]
```

---

## 🔐 Domain and SSL Setup

- Used **Route53** to manage the domain (i.e., `devopsagent.online`).
- Created an **A Record (Alias)** pointing to the **ALB DNS Name**.
- Used **ACM (AWS Certificate Manager)** to request and provision an **SSL certificate**.
- Configured the ALB to:
  - Redirect all HTTP traffic (port 80) to HTTPS (port 443)
  - Use the SSL certificate for secure communication
- The application is now accessible securely over **HTTPS** using a custom domain.

---

## 🛡️ Database Access and Dummy Data

- Since RDS instances are in private subnets, direct public access is not allowed.
- Used **SSH tunneling** through an EC2 instance to securely connect to the database:
  
```bash
ssh -i my-key.pem ec2-user@<EC2_PUBLIC_IP> -L 3306:<RDS_ENDPOINT>:3306
```

- Connected to the RDS instance using DBeaver.
- Created dummy tables and inserted test data:
  - Sample table: iot_data (timestamp, temperature, humidity)
- Verified data was being read correctly from the frontend/backend and BI tool.

## 📊 BI Tool Deployment (Metabase)
- Chose Metabase as the BI tool and deployed it via Docker on the third EC2 instance.
- Connected Metabase to the PostgreSQL RDS instance using internal credentials.
- Created a sample dashboard with:
  - A bar chart of temperature readings
  - Time-series line graphs for environmental monitoring
  - KPIs for average humidity and max temperature
- Hosted Metabase on port 3000, accessible securely via the ALB and protected by security group rules.

## 📽️ Loom Demonstration Video
🎥 Watch the Project Demo
The video includes:
  - Terraform provisioning of infrastructure
  - Dockerized application and BI tool deployment
  - Domain and SSL configuration
  - Secure database access with SSH tunneling
  - BI dashboard exploration

## 📎 GitHub Repository
All Terraform modules, Dockerfiles, user data scripts, and configurations are available at:

🔗 https://github.com/MaazBatla/DevOps-Project

Feel free to fork, clone, or contribute!

✅ Conclusion
This project provided a real-world simulation of deploying a scalable, containerized, and secure AWS environment using best DevOps practices.

Key learnings:
  - Infrastructure as Code with Terraform
  - Orchestration of Dockerized microservices
  - Networking and security with VPC, subnets, and security groups
  - End-to-end delivery pipeline from infrastructure to data visualization
