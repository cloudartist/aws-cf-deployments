# aws-cf-deployments
Cloud Formation infrastructure deployments 

## Deployment status
[![CI](https://github.com/cloudartist/aws-cf-deployments/actions/workflows/main.yml/badge.svg)](https://github.com/cloudartist/aws-cf-deployments/actions/workflows/main.yml)

## Requirement
Multi environment setup witin a single AWS account (one account per external customer)

### Envirnoment types
- Sandbox 
- Development
- Staging
- Production

This demo will be based only on 2 first envs, for sake of simplicty

## Idea
In order to achive desired outcome of seperating env workloads within a single AWS account the following Cloud Formation layering is proposed
- Layer 0 - Global (IAM setup with specific wildcard policies) #TODO - Readme link to files 
- Layer 1 - Environment (Base env infra - VPC, Subnets, NAT GW)
- Layer 2 - Platform (optional) (Databases, shared SNS topics, SQS, Kinesis, ECS Cluster) 
- Layer 3 - Application (Lambda, API GW, ECS Service)

Layer 3 consists of many seperated codebases of which code resides within the same repository as application source code and can be deployed independently.

Layer 3 code example - https://github.com/mtaracha/my-python-lambda

## CI/CD
- Commit a template code
- This tiggers a pipeline
- Create a stack from template
- Run Lint and Nag and Drift check
- Prep Change Sets
- Deploy

## Infrastructre and application code separation


## Deployments
sandbox
```
# ini style
aws cloudformation deploy --template-file templates/network.yaml --stack-name sandbox-network --parameter-overrides $(cat parameters/environments/sandbox/network.ini) --tags $(cat parameters/environments/sandbox/tags.ini) --region eu-west-1

# json style parameters
aws cloudformation deploy --template-file templates/network.yaml --stack-name sandbox-network --parameter-overrides file://parameters/environments/sandbox/network.json --tags $(cat parameters/environments/sandbox/tags.ini)--region eu-west-1
```

## Create change set 
```
aws cloudformation deploy \
--no-execute-changeset \
--stack-name sandbox-network \
--template-file templates/network.yaml \
--parameter-overrides $(cat parameters/environments/sandbox/network.ini) \
--tags $(cat parameters/environments/sandbox/tags.ini) | tee change-set.txt

CHANGE_SET_ARN=$(cat change-set.txt | grep cloudformation | awk '{print $5'})
aws cloudformation describe-change-set --change-set-name $CHANGE_SET_ARN
echo "Do you want to execute above changes?"
# TODO add link to console for visual change sets
aws cloudformation execute-change-set --change-set-name $CHANGE_SET_ARN

```

dev
```
# ini style
aws cloudformation deploy --template-file templates/network.yaml --stack-name dev-network --parameter-overrides $(cat parameters/environments/dev/network.ini) --tags $(cat parameters/environments/dev/tags.ini) --region eu-west-1
```

## Delete stack
```
aws cloudformation delete-stack --stack-name dev-network
```
