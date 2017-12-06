# Jenkins setup with Open Baton integration tests

## Setup

The 01-setup script takes care of installing the Jenkins server and the docker environment required for executing integration tests. 

```bash
./01-setup.sh
```

Modify the docker configuration adding the following line for exposing the port remotely 

```bash
sudo vim /etc/systemd/system/multi-user.target.wants/docker.service
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2376
```

Restart the docker engine: 

```bash
sudo systemctl daemon-reload
sudo service docker restart
```

Now start the docker jenkins container

```bash
./02-start-jenkins.sh
```


