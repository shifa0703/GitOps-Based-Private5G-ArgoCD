#!/bin/bash

cd /opt/UERANSIM

GNB_IP=$(getent hosts ueransim-gnb | awk '{print $1}' | head -n1)

if [ -z "$GNB_IP" ]; then
    echo "ERROR: Could not resolve ueransim-gnb"
    exit 1
fi

echo "Using gNB IP: $GNB_IP"

sed -i "/gnbSearchList:/,/uacAic:/ s/^[[:space:]]*- [0-9.]*$/  - ${GNB_IP}/" /opt/UERANSIM/config/open5gs-ue.yaml

echo "Starting UERANSIM UE..."
./build/nr-ue -c config/open5gs-ue.yaml
