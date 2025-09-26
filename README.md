
# AWS Infrastructure with Terraform

This project creates a complete AWS infrastructure using Terraform, including:

- VPC with public and private subnets across 2 availability zones
- Internet Gateway and NAT Gateways for internet access
- Auto Scaling Group with Launch Template
- Application Load Balancer
- Bastion host for secure access
- Security Groups with appropriate rules

## Setup Instructions

1. **Clone this repository**
   ```bash
   git clone <your-repo-url>
   ```

2. **Initialize Terraform**
   ```bash
   terraform init
   ```

3. **Plan the deployment**
   ```bash
   terraform plan
   ```

4. **Apply the configuration**
   ```bash
   terraform apply
   ```
   Type `yes` when prompted.

## Accessing Your Infrastructure

### Bastion Host
- SSH into the bastion host using its public IP:
  ```bash
  ssh -i /path/to/your/key.pem ubuntu@<bastion-public-ip>
  ```

### Private Instances
- From the bastion host, SSH into private instances:
  ```bash
  ssh -i /path/to/your/key.pem ubuntu@<private-instance-ip>
  ```
- Create the web content:
  ```bash
  vim index.html
  ```
- Start the Python web server:
  ```bash
  python3 -m http.server 8000
  ```
### Accessing the Web Application

- The web application is accessible through the Application Load Balancer

- Get the Load Balancer DNS name from the Terraform output

- Access your application at: `http://<load-balancer-dns-name>`

- The load balancer forwards traffic to the private instances running the web server on port 8000

## Key Components

### VPC and Networking
- **VPC**: 10.0.0.0/16 CIDR block
- **Public Subnets**: 10.0.1.0/24, 10.0.2.0/24
- **Private Subnets**: 10.0.3.0/24, 10.0.4.0/24
- **NAT Gateways**: One in each availability zone for private subnet internet access

### Security Groups
- **Bastion SG**: Allows SSH (port 22) from anywhere
- **Private SG**: Allows SSH from bastion and HTTP (port 8000) from load balancer
- **ALB SG**: Allows HTTP (port 80) from anywhere

### Auto Scaling
- **Min Size**: 1 instance
- **Max Size**: 3 instances
- **Desired**: 2 instances
- **Instance Type**: t2.micro

### Project Flow

1. Infrastructure Deployment: Terraform creates the complete AWS infrastructure
2. Bastion Access: Use bastion host to securely access private instances
3. Web Server Setup: Create index.html and start Python HTTP server on port 8000
4. Load Balancer Integration: ALB automatically detects and routes traffic to healthy instances
5. Public Access: Users can access the web application through the load balancer's public endpoint

## Cleanup

To destroy all created resources:
```bash
terraform destroy
```
Type `yes` when prompted.



