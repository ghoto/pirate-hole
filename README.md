# pirate-hole
Docker compose for nordvpn+radarr+jackett+deluge combo

# Initialization
Copy `pirate-hole.conf.template` -> `pirate-hole.conf`
```
cp pirate-hole.conf.template pirate-hole.conf
```

and edit the configurations with your needs (VPN credentials, paths for the future configurations, and download folders). First time you will run this, paths can be empty, but if you have a running system it will use those.

```
./init.sh
docker-compose up --no-start
```
This will create the environment

# Start

First you need to start the VPN container. This can't go inside the compose because docker-compose doesn't apply `network_mode: service:vpn` correctly, and you risk of leaking your IP.
```
./run-vpn.sh
```
Then,
```
docker-compose up -d
```

# Caveats

Make sure you update the basepaths for `radarr`, `deluge`, and `jackett`.

- radarr: in `$RADAR_CONFIG/config.xml` replace `<UrlBase></UrlBase>` with `<UrlBase>radarr</UrlBase>`
- deluge: in `$DELUGE_CONFIG/web.conf` replace `"base": ""` with `"base": "/deluge"`
- jackett: in `$JACKET_CONFIG/Jackett/ServerConfig.json` replace `"BasePathOverride": "",` with `"BasePathOverride": "/jackett",`

This is important because services need to be accessed by the nginx reverse proxy container, and in order to use only one the paths are used to differentiate the services.

Also in the configurations, you will need to setup radarr to work with deluge and jackett. You can follow instructions online. Only thing is that all the IP addresses for these 3 systems is `localhost` because they are all running in the VPN's "hosted" network. This means that Jackett is running at `http://localhost:9117` for Radarr.

# Usage
Once everything is up and running you can access the services at
- radarr: `http://SERVER:WEB_PORT/radarr`
- deluge: `http://SERVER:WEB_PORT/deluge`
- jackett: `http://SERVER:WEB_PORT/jackett`
