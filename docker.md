## [Install docker-compose on Linux](https://docs.docker.com/compose/install/)

```
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
```


## Docker Volumes Locations

Linux:
```/var/lib/docker/volumes/```

Mac:
```~/Library/Containers/com.docker.docker/Data/vms/0/Docker.raw```

https://stackoverflow.com/questions/19234831/where-are-docker-images-stored-on-the-host-machine/37642236#37642236


## See why a container failed                    

```docker logs --tail=50 <container id>```