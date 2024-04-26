docker container stop $(docker ps -a -q)
docker container rm  $(docker ps -a -q)
docker image rm -f $(docker image ls -a -q)
docker buildx prune -a -f 
docker volume rm -f $(docker volume ls -q)
docker network rm sl-net -f
