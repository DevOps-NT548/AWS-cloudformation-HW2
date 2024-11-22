#!/bin/bash

# Function to deploy a CloudFormation stack and wait for its completion
deploy_stack() {
  local STACK_NAME=$1
  local TEMPLATE_FILE=$2
  local OUTPUT_FILE=$3

  echo "Deploying CloudFormation stack: $STACK_NAME"

  # Execute AWS CLI command to deploy the stack
  aws cloudformation deploy \
    --template-file $TEMPLATE_FILE \
    --stack-name $STACK_NAME \
    --capabilities CAPABILITY_NAMED_IAM \
    --region us-east-1

  if [ $? -eq 0 ]; then
    echo "Stack deployment complete: $STACK_NAME" | tee -a $OUTPUT_FILE
  else
    echo "Failed to deploy stack: $STACK_NAME" | tee -a $OUTPUT_FILE
  fi
}

OUTPUT_FILE="output/deploy-output.txt"
echo "Starting stack deployment process..." | tee $OUTPUT_FILE

# Deploy stacks in the correct order
# deploy_stack "vpc-stack" "templates/vpc.yaml" $OUTPUT_FILE
# deploy_stack "nat-gateway-stack" "templates/nat-gateway.yaml" $OUTPUT_FILE
# deploy_stack "route-tables-stack" "templates/route-tables.yaml" $OUTPUT_FILE
# deploy_stack "ec2-instances-stack" "templates/ec2.yaml" $OUTPUT_FILE
deploy_stack "group-20" "templates/main.yaml" $OUTPUT_FILE

echo "All stacks deployment process completed." | tee -a $OUTPUT_FILE