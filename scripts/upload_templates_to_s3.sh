#!/bin/bash

#create key pair
aws ec2 create-key-pair --key-name my_key_pair --query 'KeyMaterial' --output text > my_key_pair.pem

# Define the S3 bucket name
S3_BUCKET="group20-testing-bucket"

# Create the S3 bucket
aws s3 mb s3://$S3_BUCKET --region us-east-1

# Upload all files in the templates folder to the S3 bucket
aws s3 cp templates/ s3://$S3_BUCKET/templates/ --recursive

echo "All templates have been uploaded to s3://$S3_BUCKET/templates/"