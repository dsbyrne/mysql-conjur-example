#!/usr/bin/env bash

IMAGE_NAME=mysql-client-example
IMAGE_TAG=0.1

# Start the MySQL container
docker-compose up -d

# Build the client image which contains summon and the mysql client
docker build -t $IMAGE_NAME:$IMAGE_TAG .

# Start a new container
# NOTE: You may need to change the link names here
container_id=`docker run -dit \
  -v $(pwd)/secrets.yml:/root/secrets.yml \
  --link mysqlconjurexample_database_1 \
  --link conjur-solo \
  $IMAGE_NAME:$IMAGE_TAG \
  bash`

# Create a new host identity in Conjur
new_host="`conjur host create`"
host_id="`echo "$new_host" | jq -r '.id'`"

# "Conjurize" the host (give it a machine identity)
docker exec -it $container_id bash -c "$(echo "$new_host" | conjurize)"

# Allow the new host to be able to read the MySQL password
conjur resource permit variable:mysql/password host:$host_id execute

# Open bash in the new container
docker exec -it $container_id bash

# We've quit out of our container - remove it
docker rm -f $container_id