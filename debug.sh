#!/bin/bash

docker stop $(docker ps -a -q --filter ancestor=flask_server)
docker rm $(docker ps -a -q --filter ancestor=flask_server)
docker run -ti -v $PWD/app:/app -p 5000:80 flask_server /bin/bash -c \
       "pip3 install -r /app/requirements.txt; \
       python3 main.py"

       # For translations...
       # pip3 install --ignore-installed setuptools==34.4.1;
       # pybabel extract -F babel.cfg -o messages.pot /app; \
       # pybabel init -i messages.pot -d /app/translations -l es; \
       # pybabel compile -d /app/translations; \


