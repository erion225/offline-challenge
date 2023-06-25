# CloudFormation Template - Terraform backend state managed in S3

This CloudFormation template creates S3 resources and a DynamoDB table for Terraform state lock using the S3 Backend.

## Parameters

- `StackName`: Enter the desired name for the stack.
- `Purpose`: Enter the purpose of the stack.
- `Environment`: Enter the environment for the stack.

## Resources

### S3Bucket

### DynamoDbTableS3Backend

### KMSKey

# Create Cloudformation stack

Note: Change aws region in below command

```
aws cloudformation create-stack --stack-name production-tf-state --template-body file://tfstate_encrypted_cfn.yaml --parameters ParameterKey=StackName,ParameterValue=jenkins ParameterKey=Purpose,ParameterValue=terraform-state ParameterKey=Environment,ParameterValue=production --region <>
```