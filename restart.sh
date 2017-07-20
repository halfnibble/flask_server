#!/bin/bash
docker stop $(docker ps -a -q --filter ancestor=flask_server)
docker run -d -v $PWD/app:/app -p 5000:80 --restart unless-stopped flask_server


