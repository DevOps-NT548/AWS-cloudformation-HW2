#!/bin/bash

# Function to delete a CloudFormation stack and wait for its deletion
delete_stack() {
  local STACK_NAME=$1
  local OUTPUT_FILE=$2

  echo "Deleting CloudFormation stack: $STACK_NAME"

  # Execute AWS CLI command to delete the stack
  if aws cloudformation delete-stack --stack-name $STACK_NAME --region us-east-1; then
    # Wait for the stack to be deleted completely
    echo "Waiting for stack deletion to complete..."
    aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME --region us-east-1

    if [ $? -eq 0 ]; then
      echo "Stack deletion complete: $STACK_NAME" | tee -a $OUTPUT_FILE
    else
      echo "Failed to wait for deletion of stack: $STACK_NAME" | tee -a $OUTPUT_FILE
    fi
  else
    echo "Failed to delete stack: $STACK_NAME" | tee -a $OUTPUT_FILE
  fi
}

OUTPUT_FILE="output/destroy-output.txt"
echo "Starting stack deletion process..." | tee $OUTPUT_FILE

# Delete stacks in reverse order of creation to avoid dependency issues
# delete_stack "security-groups-stack" $OUTPUT_FILE
# delete_stack "ec2-instances-stack" $OUTPUT_FILE
# delete_stack "nat-gateway-stack" $OUTPUT_FILE
# delete_stack "route-tables-stack" $OUTPUT_FILE
# delete_stack "vpc-stack" $OUTPUT_FILE
delete_stack "group20" $OUTPUT_FILE
 
echo "All stacks deletion process completed." | tee -a $OUTPUT_FILE