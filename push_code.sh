#!/bin/bash

rm ../GetBreeds.zip

zip ../GetBreeds.zip ./src/GetBreeds/* 


# Will fail if function has not been deployed 
aws lambda update-function-code \
--function-name standard-data-dev-GetBreeds \
----zip-file fileb://../GetBreeds.zip
--region us-east-1

# S3 upload
# aws s3 cp ../example.zip s3://326347646211-terraform-serverless-example/v1.0.0/example.zip

# aws lambda update-function-code \
# --function-name standard-data-dev-GetBreeds \
# --s3-bucket 326347646211-terraform-serverless-example \
# --s3-key v1.0.0/example.zip \
# --region us-east-1