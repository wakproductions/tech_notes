## [Install docker-compose on Linux](https://docs.docker.com/compose/install/)

```
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
```
## How to exit `docker attach` without shutting down container

`Ctrl+P + Ctrl+Q`


## Clean up temporary shit
in particular the `/var/lib/docker/overlay2` folder

```
docker rm $(docker ps -a -q)
docker image prune --all
docker system prune -a

sudo du -h -d1 /var/lib/docker
4.0K    /var/lib/docker/tmp
14M     /var/lib/docker/buildkit
4.0K    /var/lib/docker/runtimes
16K     /var/lib/docker/plugins
95M     /var/lib/docker/volumes
9.9M    /var/lib/docker/image
12G     /var/lib/docker/overlay2
4.0K    /var/lib/docker/trust
4.0K    /var/lib/docker/swarm
25M     /var/lib/docker/containers
112K    /var/lib/docker/network
12G     /var/lib/docker
```


## Docker Volumes Locations

Linux:
```/var/lib/docker/volumes/```

Mac:
```~/Library/Containers/com.docker.docker/Data/vms/0/Docker.raw```

WSL:
```//$wsl//docker-desktop-data/version-pack-data/docker/volumes/```
```\\wsl.localhost\docker-desktop-data\data\docker\volumes```

https://stackoverflow.com/questions/19234831/where-are-docker-images-stored-on-the-host-machine/37642236#37642236


## See why a container failed                    

```docker logs --tail=50 <container id>```


## Reduce Docker VM Size in Windows WSL

`Optimize-VHD -Path c:\path\to\data.vhdx -Mode Full`


Path to Docker solume is `%LOCALAPPDATA%\Docker\wsl\data\ext4.vhdx`


https://dev.to/marzelin/how-to-reduce-size-of-docker-data-volume-in-docker-desktop-for-windows-v2-5d38


## Networking problem of 3/3/21

Docker suddenly couldn't connect to the database on the host machine anymore. It seems that the IP address 
of 192.168.1.185 that I using to access the host machine had changed within the Docker network. Found the new ip address
by going into the container and running:
```
# ip route
default via 192.168.0.1 dev eth0
192.168.0.0/20 dev eth0 proto kernel scope link src 192.168.0.3
```

# Docker volume size limit on WSL

`–storage-driver=devicemapper --storage-opt dm.basesize=20G`

https://forums.docker.com/t/increase-container-volume-disk-size/1652/12
https://docs.docker.com/engine/reference/commandline/dockerd/#storage-driver-options


Original Settings (Docker Desktop 4.16.3, Engine: Docker version 20.10.22, build 3a2c30b):

`C:\Users\Winston Kotzan\.docker\daemon.json`


```
{
  "builder": {
    "gc": {
      "defaultKeepStorage": "20GB",
      "enabled": true
    }
  },
  "experimental": false,
  "features": {
    "buildkit": true
  }
}
```

New Settings:
```
{
  "builder": {
    "gc": {
      "defaultKeepStorage": "20GB",
      "enabled": true
    }
  },
  "experimental": false,
  "features": {
    "buildkit": true
  },
  "storage-opt": [
    "size=50GB"
  ]
}
```