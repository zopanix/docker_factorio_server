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

# Checking options
if [ "$FACTORIO_DISSALOW_COMMANDS" == false  ]; then
  disallow_commands=""
else
  disallow_commands="--disallow-commands"
fi
if [ "$FACTORIO_NO_AUTO_PAUSE" == true ]; then
  no_auto_pause="--no-auto-pause"
else
  no_auto_pause=""
fi
echo "###"
echo "# Launching Game"
echo "###"
exec /opt/factorio/bin/x64/factorio \
  $disallow_commands \
  $no_auto_pause \
  --autosave-interval ${FACTORIO_AUTOSAVE_INTERVAL} \
  --autosave-slots ${FACTORIO_AUTOSAVE_SLOTS} \
  --start-server \
  $last_save 
