#!/bin/bash
set -e

rm ../BreedsList.zip
rm ../BreedsGet.zip

zip ../BreedsList.zip ./src/BreedsList/*
zip ../BreedsGet.zip ./src/BreedsGet/*


# Will fail if function has not been deployed 
aws lambda update-function-code \
--function-name standard-data-dev-breeds-list \
--zip-file fileb://../BreedsList.zip \
--region us-east-1

aws lambda update-function-code \
--function-name standard-data-dev-breeds-get \
--zip-file fileb://../BreedsList.zip \
--region us-east-1

# S3 upload
# aws s3 cp ../example.zip s3://326347646211-terraform-serverless-example/v1.0.0/example.zip

# aws lambda update-function-code \
# --function-name standard-data-dev-GetBreeds \
# --s3-bucket 326347646211-terraform-serverless-example \
# --s3-key v1.0.0/example.zip \
# --region us-east-1