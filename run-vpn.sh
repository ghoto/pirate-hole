#!/bin/bash

source pirate-hole.conf

docker run --rm -ti --cap-add=NET_ADMIN --cap-add=SYS_MODULE --device /dev/net/tun --name vpn \
	--sysctl net.ipv4.conf.all.rp_filter=2 \
	-e USER=$VPNUSER -e PASS="$VPNPASS" \
	-e CONNECT=us -e TECHNOLOGY=NordLynx -d bubuntux/nordvpn
