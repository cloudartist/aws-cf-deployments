# Templates

## Nested stacks 

Nested stack require template to be avialable in S3.

To copy your 
#TODO to be added to CI on commit message cf-template
```
# bucket name from [s3.ini](../parameters/global/s3.ini)
aws s3 cp templates/ec2.yaml s3://cloudformation-templates-cloudastic
```
