#!/bin/sh
cp /var/lib/letsencrypt/davmail/*.pem ./
docker build -t docker.stir.ac.uk/docker-davmail:latest .
rm *.pem
docker push docker.stir.ac.uk/docker-davmail:latest
