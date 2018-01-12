#!/bin/bash

#Get the image

url=$(curl -ksS "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY"  | jq -r '.hdurl')

#Retrieve basename

test=$(basename $url)


wget -q -P ~/Pictures/apod/ $url -o /home/axel/APODlogs.txt

# TODO : - Check file extension (if you can set it as background) (media_type)
#        - Check if file already exist
#	 - Add explanations

#Need for cron

PID=$(pgrep gnome-session)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

sleep 5

#Set as background

gsettings set org.gnome.desktop.background picture-uri file:///$HOME/Pictures/apod/"$test"
