#!/bin/bash
set -e

sudo docker network create votingapp || true

# cleanup
sudo docker rm -f myvotingapp || true
sudo docker rm -f myredis || true

# build
sudo docker build -t pclararobles/votingapp ./src/votingapp
sudo docker run --name myredis --network votingapp -d redis 
sudo docker run --name myvotingapp --network votingapp -p 8080:80 -e REDIS="myredis:6379" -d pclararobles/votingapp
 
# test
sudo docker build -t pclararobles/votingapp-test ./test
sudo docker run --rm -e VOTINGAPP_HOST="myvotingapp" --network votingapp pclararobles/votingapp-test


# delivery
sudo docker push  pclararobles/votingapp