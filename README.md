# pirate-hole
Docker compose for gluetun+radarr+sonarr+jackett+deluge combo

# Initialization
Copy `pirate-hole.conf.template` -> `pirate-hole.conf`
```
cp pirate-hole.conf.template pirate-hole.conf
```

and edit the configurations with your needs (VPN credentials, paths for the future configurations, and download folders). First time you will run this, paths can be empty, but if you have a running system it will use those.

*Note*: if you run docker as `root`, then you must set the `USERID` and `GROUPID` to the desired values (typically yours).

```
./init.sh
```

# Start

Execute
```
docker-compose up -d
```

# Notes

You will need to setup each individual service using their web interfaces. 

For integrations with `deluge` and `jackett` with `sonarr` and `radarr`, their IP addresses is `localhost`. This is because they share the same network as the VPN container.
E.g. Jackett is running at `http://localhost:9117`

# Usage
Once everything is up and running you can access the services at
- radarr: `http://SERVER:WEB_PORT/radarr`
- sonarr: `http://SERVER:WEB_PORT/sonarr`
- deluge: `http://SERVER:WEB_PORT/deluge`
- jackett: `http://SERVER:WEB_PORT/jackett`
