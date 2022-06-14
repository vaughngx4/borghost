#!/bin/bash
docker-compose rm -sf
docker rmi sintelli/borgbase:latest
bash ./build.sh
