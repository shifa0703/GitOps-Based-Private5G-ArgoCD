#!/bin/bash

cd /opt/UERANSIM

cp /opt/UERANSIM/config/open5gs-ue.yaml /tmp/open5gs-ue.yaml

echo "Using gNB Service: ueransim-gnb"

sed -i '/gnbSearchList:/,/uacAic:/ s/^[[:space:]]*- .*/  - ueransim-gnb/' /tmp/open5gs-ue.yaml

echo "Starting UERANSIM UE..."
./build/nr-ue -c /tmp/open5gs-ue.yaml
