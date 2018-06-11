# Docker maintenance

# Setting up Docker dev machine
1. Install Docker for Windows https://store.docker.com/editions/community/docker-ce-desktop-windows

# Remove all stopped containers, dangling images, network and build cache
docker system prune

# Check storage used by docker
docker system df