#!/bin/bash
set -e

mkdir -p deploy/build

# helpers for zipping lambdas function code
# use these before terraform has created resources
rm -f deploy/build/BreedsList.zip
rm -f deploy/build/BreedsGet.zip
rm -f deploy/build/utils.zip

zip deploy/build/BreedsList.zip ./src/BreedsList/*
zip deploy/build/BreedsGet.zip ./src/BreedsGet/*

# zip lambda layer
cd src/utils
zip -r ../../deploy/build/utils.zip nodejs/*
cd -