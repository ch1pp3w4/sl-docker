docker stop $(docker ps -a -q) & docker update --restart=no $(docker ps -a -q) & sudo systemctl restart docker
