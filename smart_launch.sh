#!/bin/bash

if [ -f /opt/factorio/saves/save.zip ]
then
  echo "###"
  echo "# Using existing map [save.zip]"
  echo "###"
else
  echo "###"
  echo "# Creating a new map [save.zip]"
  echo "###"
  /opt/factorio/bin/x64/factorio --create save.zip
  echo "###"
  echo "# New map created [save.zip]"
  echo "###"
fi

echo "###"
echo "# Launching Game"
echo "###"
exec /opt/factorio/bin/x64/factorio --disallow-commands --start-server save.zip
