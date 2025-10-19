🌍 terraform — Infrastructure as Code
📖 Overview

This branch uses Terraform to define and provision cloud infrastructure required for the CI/CD and deployment environments.

🧱 Purpose

Automate provisioning of VMs, networking, or Kubernetes clusters.

Maintain infrastructure as version-controlled code.

📁 Key Files

main.tf – main Terraform configuration.

variables.tf – defines inputs like region, instance type, etc.

outputs.tf – defines outputs like IP addresses or instance IDs.

⚙️ Typical Commands
terraform init
terraform plan
terraform apply
terraform destroy

🧩 Possible Resources

Virtual Machines (for Jenkins or Docker host)

Resource groups (Azure)

Kubernetes clusters

Storage and networking components
