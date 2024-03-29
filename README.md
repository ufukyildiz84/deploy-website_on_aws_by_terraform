# Deploying E-Store Website on AWS Using Terraform

This guide provides instructions for deploying an e-store website on AWS using Terraform. The deployment process includes setting up EC2 instances, RDS database, security groups, and VPC configurations.

## Prerequisites

- AWS account with appropriate permissions
- Terraform installed on your local machine

## Project Structure

The project consists of several Terraform configuration files:

1. **command.sh**: Contains commands to launch the e-store website.
2. **ec2.tf**: Defines resources for launching an EC2 instance and installing the website.
3. **providers.tf**: Specifies the required AWS provider and version.
4. **rds.tf**: Defines resources for creating an RDS database instance.
5. **security-group.tf**: Configures security groups for the web server and RDS instance.
6. **userdata.tpl**: Template file for configuring the EC2 instance.
7. **var.tf**: Defines input variables such as AWS region, CIDR blocks, and database credentials.
8. **vpc.tf**: Configures the VPC, subnets, and internet gateway.

## Getting Started

1. Clone this repository to your local machine:

    ```bash
    git clone <repository_url>
    ```

2. Navigate to the project directory:

    ```bash
    cd deploy-website_on_aws_by_terraform
    ```

3. Initialize Terraform:

    ```bash
    terraform init
    ```

4. Review and modify the input variables in `var.tf` if necessary.

5. Generate and review an execution plan to ensure that Terraform will perform the correct actions:

    ```bash
    terraform plan
    ```

6. Deploy the infrastructure by running:

    ```bash
    terraform apply
    ```

7. Follow the prompts to confirm the deployment.

8. Once the deployment is complete, Terraform will output the endpoint, username, password, and database name for accessing the RDS instance.

9. Access the website using the public IP address or DNS name of the EC2 instance.

## Additional Notes

- Ensure that your AWS credentials are properly configured on your local machine.
- Review the security group configurations to restrict access as needed.
- Customize the website by modifying the contents of the `store-dir` directory.

## Clean Up

To avoid incurring unnecessary costs, remember to destroy the resources once you're done:

```bash
terraform destroy
```

## Support

For any issues or questions, please open an issue in the repository or contact [ufukyildiz84@hotmail.com](mailto:ufukyildiz84@hotmail.com).

---

Feel free to customize the README further based on your project's specific requirements and additional documentation needs.