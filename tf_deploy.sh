#!/bin/bash

cd deploy

terraform fmt

terraform validate

terraform apply

cd -