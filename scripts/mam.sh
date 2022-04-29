#!/bin/bash
# My Anonamous Support
# Copy this file to deluge-conf/custom-init.d/
# First time installation, once deluge is running execute
# docker-compose exec deluge curl -b 'MAM_IDi' https://t.myanonamouse.net/json/dynamicSeedbox.php

tee /etc/periodic/15min/mam.sh <<EOF
#!/bin/bash
curl -c /config/mam.cookie -b /config/mam.cookie https://t.myanonamouse.net/json/dynamicSeedbox.php
EOF

/usr/sbin/crond -S -l 0 -c /etc/crontabs
