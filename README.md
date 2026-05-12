

***

# 🚀 Automated Secure CI/CD Deployment with Terraform, Ansible, Jenkins & AWS

This repository contains the complete infrastructure as code (IaC), configuration management, and CI/CD pipeline required to securely deploy a containerised Node.js application on AWS. 

This project demonstrates a **security-first cloud architecture**, placing all compute resources in private subnets, routing configuration traffic through a Bastion Host, and exposing the application to the internet exclusively via an Application Load Balancer.

## 🏗️ Architecture & Workflow

<img width="2752" height="1536" alt="unnamed" src="https://github.com/user-attachments/assets/caa8243e-3000-4e50-9f44-290253391640" />



1. **Infrastructure Provisioning:** **Terraform** provisions the AWS VPC, Public/Private Subnets, EC2 instances (Bastion & Private Nodes), RDS, Redis, and an Application Load Balancer (ALB).
2. **Configuration Management:** **Ansible** accesses the private EC2 instance securely via the Bastion Host using SSH ProxyJump to install necessary dependencies (Java, Git, Docker).
3. **CI/CD Integration:** A local **Jenkins Master** connects to the Private EC2 Jenkins Agent using **JNLP** (Java Network Launch Protocol), bypassing the need for a public IP.
4. **Application Deployment:** The Jenkins pipeline builds a **Docker** image of the Node.js application, pushes it to DockerHub, and runs the container securely on the private instance, injecting RDS and Redis credentials.
5. **Traffic Routing:** End users access the application via the **AWS ALB**, which routes traffic to the private Docker container. Direct access to the EC2 instances is blocked by strict Security Group rules.

## 📂 Repository Structure

*   `terraform/`: Contains all HCL code to provision the AWS network, security groups, EC2 instances, databases, and load balancer.
*   `ansible/`: Contains playbooks and inventory files to configure the EC2 instances.
*   `nodeapp/`: Contains the Node.js application source code, Dockerfile, and the `Jenkinsfile` for the CI/CD pipeline.

---

## 🚀 How to Run the Environment

### Prerequisites
*   AWS CLI configured with appropriate credentials.
*   Terraform and Ansible installed locally.
*   A running Jenkins controller.
*   A DockerHub account.

### Step 1: Provision Infrastructure with Terraform
1. Navigate to the `terraform/` directory.
2. Initialize and apply the configuration:
   ```bash
   terraform init
   terraform select workspace dev
   terraform apply --auto-approve
   ```
3. **Important:** Note the outputs provided by Terraform, specifically the ALB DNS name, RDS endpoints, Redis endpoints, and the IP addresses of your Bastion and Private EC2 instances.

### Step 2: Configure Secure SSH Access
To allow Ansible to communicate with the private EC2 instance, configure your local SSH to use the Bastion host as a jump proxy. Add the following to your `~/.ssh/config` file:

```text
# The Gateway (Bastion)
Host bastion
    HostName <BASTION_PUBLIC_IP>
    User ec2-user
    IdentityFile /path/to/your/key.pem

# The Private Servers
Host 10.0.*.*
    User ec2-user
    IdentityFile /path/to/your/key.pem
    ProxyJump bastion
```

### Step 3: Configure the Jenkins Agent via Ansible
1. Navigate to the `ansible/` directory.
2. Update your `inventory.ini` file with the Private IP of the EC2 instance.
3. Run the playbook to install Java (Amazon Corretto), Git, and Docker on the private instance, and add `ec2-user` to the docker group:
   ```bash
   ansible-playbook -i inventory.ini playbook.yml
   ```

### Step 4: Connect the Jenkins Agent (JNLP)
Because the Jenkins agent is in a private subnet, it must initiate the connection to the Jenkins Master using JNLP.
1. In the Jenkins dashboard, create a new Node and select "Launch agent by connecting it to the controller".
2. SSH into your private EC2 instance (via the Bastion).
3. Create a working directory (e.g., `/home/ec2-user/node`).
4. Download the `agent.jar` file and execute the JNLP command provided by Jenkins (which includes your Jenkins URL and secret token). 
5. Confirm in the Jenkins dashboard that the node is successfully connected.

### Step 5: Execute the CI/CD Pipeline
1. In Jenkins, create the necessary credentials:
   *   `dockerhub` (Username and Password)
   *   `rds-url-secret`, `rds-user-secret`, `rds-pass-secret`
   *   `redis-url-secret`
2. Create a new Pipeline job pointing to the `Jenkinsfile` in the `nodeapp/` directory.
3. Run the build. The pipeline will automatically:
   * Pull the code.
   * Build the Docker image.
   * Push it to DockerHub.
   * Run the container on the private EC2 instance on Port 80, injecting the DB credentials as environment variables.

### Step 6: Verify the Deployment
To test if the application has successfully connected to the stateful backend databases, navigate to the ALB DNS name generated in Step 1 in your web browser:

*   **Test RDS:** `http://<ALB_DNS_NAME>/db` -> Should return *db connection successful*.
*   **Test Redis:** `http://<ALB_DNS_NAME>/redis` -> Should return *redis is successfully connected*.
