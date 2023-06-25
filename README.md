# Jenkins infrastructure - AWS hosted

## Architecture

![Architecture](./images/jenkins_infra.png)


## Terraform Configuration

To use the created S3 bucket and DynamoDB table in your Terraform configuration, you can use the following configuration:

```hcl
terraform {
  backend "s3" {
    bucket         = "jenkins-terraform-state-production"
    encrypt        = "true"
    kms_key_id     = "arn:aws:kms:ap-south-1:278306660155:alias/jenkins-terraform-state-key-production"
    region         = "ap-south-1"
    dynamodb_table = "jenkins-terraform-state-production"
    key            = "jenkins/production.tfstate"
  }
}