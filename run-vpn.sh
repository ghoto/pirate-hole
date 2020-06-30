#!/bin/bash

source vpn.conf

docker run --rm -ti --cap-add=NET_ADMIN --cap-add=SYS_MODULE --device /dev/net/tun --name vpn \
	--sysctl net.ipv4.conf.all.rp_filter=2 \
	-e USER=$user -e PASS="$pass" \
	-e CONNECT=us -e TECHNOLOGY=NordLynx -d bubuntux/nordvpn
