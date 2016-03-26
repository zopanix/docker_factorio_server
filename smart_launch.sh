#!/bin/bash

if [ -f /opt/factorio/saves/save.zip ]
then
  echo "###"
  echo "# Using existing map [save.zip]"
  echo "###"
  echo "###"
  echo "# Finding latest map"
  echo "###"
  last_save=$(ls /opt/factorio/saves -lt | grep save |head -1 |awk '{print $(NF)}')
else
  echo "###"
  echo "# Creating a new map [save.zip]"
  echo "###"
  /opt/factorio/bin/x64/factorio --create save.zip
  last_save="save.zip"
  echo "###"
  echo "# New map created [save.zip]"
  echo "###"
fi

echo "###"
echo "# Launching Game"
echo "###"
exec /opt/factorio/bin/x64/factorio \
  --disallow-commands \
  --start-server \
  --autosave-interval ${FACTORIO_AUTOSAVE_INTERVAL} \
  --autosave-slots ${FACTORIO_AUTOSAVE_SLOTS} \
  $last_save 
