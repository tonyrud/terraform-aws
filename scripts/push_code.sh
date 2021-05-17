#!/bin/bash
set -e

# use these after terraform has created resources

# Will fail if function has not been deployed 
aws lambda update-function-code \
--function-name standard-data-dev-breeds-list \
--zip-file fileb://deploy/code/BreedsList.zip \

aws lambda update-function-code \
--function-name standard-data-dev-breeds-get \
--zip-file fileb://deploy/code/BreedsGet.zip \

# Lambda Layer
# aws lambda publish-layer-version \
#     --layer-name utils \
#     --zip-file fileb://./deploy/build/utils.zip \
#     --compatible-runtimes nodejs12.x

# aws lambda update-function-configuration \
#     --function-name standard-data-dev-breeds-get \
#     --layers arn:aws:lambda:us-east-1:326347646211:layer:utils:7



# S3 upload
# aws s3 cp ../example.zip s3://326347646211-terraform-serverless-example/v1.0.0/example.zip

# aws lambda update-function-code \
# --function-name standard-data-dev-GetBreeds \
# --s3-bucket 326347646211-terraform-serverless-example \
# --s3-key v1.0.0/example.zip \
# --region us-east-1