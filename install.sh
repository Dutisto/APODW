#!/bin/bash

echo "Installing necessary tools..."

apt-get install jq curl &>/dev/null

sed -i 's/USER/'"$1"'/g' apodw.service

echo "Installing service..."

cp apodw.service /etc/systemd/system/
cp apodw.timer /etc/systemd/system/

cp apodw /usr/bin/apodw

systemctl enable apodw.service
systemctl enable apodw.timer

echo "Starting service..."

service apodw start || echo "something went wrong during APODW start up =["
