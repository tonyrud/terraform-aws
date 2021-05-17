#!/bin/bash

set -e

cd deploy

terraform fmt

terraform validate

terraform apply

cd -