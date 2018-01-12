#!/bin/bash

#Get the image

#Todo: wait until we have connection

wget -q --spider http://google.com

if [ ! $? -eq 0 ]; then
  echo "online"
else
  echo "offline"
fi

json=$(curl -ksS "https://api.nasa.gov/planetary/apod?api_key=IAosqZyINopWP5gdUZZC3Sw8LLfp8KY8szKskkns")

media_type=$(jq -r '.media_type' <<< "${json}")

url=$(jq -r '.hdurl' <<< "${json}")

#Retrieve basename

img=$(basename $url)

if [ $media_type == "image" ]
then
  echo "it's an image !"
  if [ ! -f /home/axel/Pictures/apod/"$img" ]
  then

    wget -P ~/Pictures/apod/ $url -o /home/axel/APODlogs.txt

    # TODO :
    #	 - Add explanations

    #Need for cron

    PID=$(pgrep gnome-session)
    export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

    sleep 5

    #Set as background

    gsettings set org.gnome.desktop.background picture-uri file:///$HOME/Pictures/apod/"$img" >> /home/axel/APODlogs.txt
  else
    echo "Already in folder"
fi
else
  echo "Not an image :("
fi
