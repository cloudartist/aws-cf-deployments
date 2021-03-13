# aws-cf-deployments
Cloud Formation infrastructure deployments 

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
