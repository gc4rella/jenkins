#!/bin/sh
#
# This script allows you to install jenkins required for open baton ci

set -u

check_binary () {
  echo -n " * Checking for '${1}' ... "
  if command -v ${1} >/dev/null 2>&1; then
     echo "OK"
     return 0
  else
     echo >&2 "FAILED"
     return 1
  fi
}

_ex='sh -c'
if [ "${USER}" != "root" ]; then
    if check_binary sudo; then
        _ex='sudo -E sh -c'
    elif check_binary su; then
        _ex='su -c'
    fi
fi

install_docker() {
	$_ex 'apt-get install apt-transport-https ca-certificates curl software-properties-common'
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | $_ex 'apt-key add -'
	$_ex 'apt-key fingerprint 0EBFCD88'
	$_ex 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"'
	$_ex 'apt-get update'
	$_ex 'apt-get install -y docker-ce'
	$_ex 'usermod -aG docker ubuntu'
}


build_jenkins_image() {
	 $_ex 'docker build . -t jenkins/jenkins:lts-local'
}

install_docker
build_jenkins_image
