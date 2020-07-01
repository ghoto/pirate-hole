#!/bin/bash

source pirate-hole.conf
rm -f docker-compose.yml
envsubst <"docker-compose.yml.template"> "docker-compose.yml"
docker-compose config -q
