#!/bin/bash

source pirate-hole.conf

if [ -n $HOST_NET ]; then
	WHITELIST="-e NETWORK=$HOST_NET"
fi

docker run --rm -ti --cap-add=NET_ADMIN --cap-add=SYS_MODULE --device /dev/net/tun --name vpn \
	--sysctl net.ipv4.conf.all.rp_filter=2 \
	-e USER=$VPNUSER -e PASS="$VPNPASS" \
	-e CONNECT=us -e TECHNOLOGY=NordLynx $WHITELIST -d bubuntux/nordvpn
