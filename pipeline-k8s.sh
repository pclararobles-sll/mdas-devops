#!/bin/bash

docker-compose rm -f && \
docker-compose up --build -d && \
docker-compose push && \
kubectl apply -f votingapp.yaml && \
kubectl run mytests \
    --generator=run-pod/v1 \
    --image=paulopez/votingapp-test \
    --env VOTINGAPP_HOST=myvotingapp.votingapp \
    --rm --attach --restat=Never && \
echo "GREEN" || echo "RED" 

# deploy

