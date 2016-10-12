## Docker rtorrent
Creates an rtorrent docker container

#### Building container
```
docker build -t yourusername/rtorrent .
```

#### Starting container
````
docker run -d --restart always --name rtorrent -v /data/rtorrent:/data/rtorrent -v /docker/rtorrent:/config -p 127.0.0.1:5000:5000 -p 49300:49300 limed/rtorrent /app/startup.sh
```
