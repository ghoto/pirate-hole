#!/bin/bash

source pirate-hole.conf
rm -f docker-compose.yml
envsubst <"docker-compose.yml.template"> "docker-compose.yml"
docker-compose config -q
docker-compose up -d vpn sonarr radarr deluge jackett
while ! test -f "$RADARR_CONFIG/config.xml"; do
  sleep 10
  echo "Waiting for $RADARR_CONFIG/config.xml"
done
sed -i 's|<UrlBase></UrlBase>|<UrlBase>radarr</UrlBase>|' $RADARR_CONFIG/config.xml

while ! test -f "$SONARR_CONFIG/config.xml"; do
  sleep 10
  echo "Waiting for $SONARR_CONFIG/config.xml"
done
sed -i 's|<UrlBase></UrlBase>|<UrlBase>sonarr</UrlBase>|' $SONARR_CONFIG/config.xml

while ! test -f "$DELUGE_CONFIG/web.conf"; do
  sleep 10
  echo "Waiting for $DELUGE_CONFIG/web.conf"
done
sed -i 's|"base": ""|"base": "/deluge"|' $DELUGE_CONFIG/web.conf

while ! test -f "$JACKETT_CONFIG/Jackett/ServerConfig.json"; do
  sleep 10
  echo "Waiting for $JACKETT_CONFIG/Jackett/ServerConfig.json"
done
sed -i 's|"BasePathOverride": null|"BasePathOverride": "/jackett"|' $JACKETT_CONFIG/Jackett/ServerConfig.json
docker-compose down
