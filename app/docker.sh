#!/bin/bash

# Login to AWS
sudo aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${account_id}.dkr.ecr.${region}.amazonaws.com

# Build container
docker build -t ${registry_url}:latest .
docker build -t ${registry_url}:${image_tag} .

# Push container to AWS
docker push ${registry_url}:latest
docker push ${registry_url}:${image_tag}