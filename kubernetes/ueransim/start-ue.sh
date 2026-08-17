#!/bin/bash

cd /opt/UERANSIM

GNB_IP=$(getent hosts ueransim-gnb | awk '{print $1}' | head -n1)

if [ -z "$GNB_IP" ]; then
    echo "ERROR: Could not resolve ueransim-gnb"
    exit 1
fi

echo "Resolved gNB Service to IP: $GNB_IP"

cp /opt/UERANSIM/config/open5gs-ue.yaml /tmp/open5gs-ue.yaml

sed -i "/gnbSearchList:/,/uacAic:/ s/^[[:space:]]*- .*/  - ${GNB_IP}/" /tmp/open5gs-ue.yaml

echo "UE gNB search list:"
grep -n -A2 "gnbSearchList" /tmp/open5gs-ue.yaml

echo "Starting UERANSIM UE..."
./build/nr-ue -c /tmp/open5gs-ue.yaml
