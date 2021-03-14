# Content

## Cloudformation templates S3 bucket

#TODO to be added to CI on commit message cf-template
```
# bucket name from [s3.ini](../parameters/global/s3.ini)
aws s3 cp templates/ec2.yaml s3://cloudformation-templates-cloudastic
```

## Wildcard IAM policies
Create wildcard IAM policies to allow changes only resoucres with names matching a given env resoucres

### Naming convention 
Naming convention is critcial part of the whole setup 
