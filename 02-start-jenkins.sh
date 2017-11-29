#!/bin/bash

# running jenkins in docker, executing docker container on this host: https://github.com/moby/moby/issues/1143
export DOCKERHOST=$(ifconfig | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print $2 }' | cut -f2 -d: | head -n1)
#docker run -d -p 9090:8080 -p 50000:50000 --add-host "dockerhost:$DOCKERHOST" -v /var/run/docker.sock:/var/run/docker.sock -v jenkins_home:/var/jenkins_home -v `pwd`/config:/var/openbaton --name openbaton-ci jenkins/jenkins:lts-local 
docker run -d -p 9090:8080 -p 50000:50000 --add-host "dockerhost:$DOCKERHOST" -v jenkins_home:/var/jenkins_home -v `pwd`/config:/var/openbaton --name openbaton-ci jenkins/jenkins:lts-local 

