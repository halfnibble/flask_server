#!/bin/bash

docker stop $(docker ps -a -q --filter ancestor=flask_server)
docker start $(docker ps -a -q --filter ancestor=flask_server)


