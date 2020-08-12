#!/bin/bash

source pirate-hole.conf

if [ -n $HOST_NET ]; then
	WHITELIST="-e NETWORK=$HOST_NET"
fi

docker run -ti --cap-add=NET_ADMIN --cap-add=SYS_MODULE --device /dev/net/tun --restart unless-stopped --name vpn \
	--sysctl net.ipv4.conf.all.rp_filter=2 \
	--health-timeout=30s --health-retries=10 --health-interval=30s \
	-e USER=$VPNUSER -e PASS="$VPNPASS" \
	-e CONNECT=$VPNSERVER -e TECHNOLOGY=NordLynx $WHITELIST -d bubuntux/nordvpn
