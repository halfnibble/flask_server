#!/bin/bash
docker run -d -v $PWD/app:/app -p 5000:80 --restart unless-stopped flask_server


