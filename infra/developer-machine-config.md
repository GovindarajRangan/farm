# Docker maintenance

# Remove all stopped containers
docker rm $(docker ps -a -q)