#!/bin/bash

# Checking if server is ready 
if [ $FACTORIO_WAITING == true ] 
then 
  until [ -f /opt/factorio/saves/ready ] 
  do 
    echo "# Waiting for backup daemon to be ready" 
    sleep 1 
  done 
fi
# Setting initial command
factorio_command="/opt/factorio/bin/x64/factorio"
# Setting heavy mode option
if [ "$FACTORIO_MODE" == "heavy" ]
then
factorio_command="$factorio_command --heavy"
fi
# Setting complete mode option
if [ "$FACTORIO_MODE" == "complete" ]
then
factorio_command="$factorio_command --complete"
fi
# Setting allow-commands option
factorio_command="$factorio_command --allow-commands $FACTORIO_ALLOW_COMMANDS"
# Setting auto-pause option
if [ "$FACTORIO_NO_AUTO_PAUSE" == true ] 
then
factorio_command="$factorio_command --no-auto-pause"
fi
# Setting latency-ms option
factorio_command="$factorio_command --latency-ms $FACTORIO_LATENCY_MS"
# Setting autosave-interval option
factorio_command="$factorio_command --autosave-interval $FACTORIO_AUTOSAVE_INTERVAL"
# Setting autosave-slots option
factorio_command="$factorio_command --autosave-slots $FACTORIO_AUTOSAVE_SLOTS"
# Setting rcon-port option
factorio_command="$factorio_command --rcon-port 27015"
# Setting rcon password option
if [ -z $FACTORIO_RCON_PASSWORD ]
then
  FACTORIO_RCON_PASSWORD=$(cat /dev/urandom | tr -dc 'a-f0-9' | head -c16)
  echo "###"
  echo "# RCON password is '$FACTORIO_RCON_PASSWORD'"
  echo "###"
fi
factorio_command="$factorio_command --rcon-password $FACTORIO_RCON_PASSWORD"
# Handling save settings
save_dir="/opt/factorio/saves"
if [ -z $FACTORIO_SAVE ]
then
  if [ "$(ls -A $save_dir)" ]
  then
    echo "###"
    echo "# Taking latest save"
    echo "###"
  else
    echo "###"
    echo "# Creating a new map [save.zip]"
    echo "###"
    /opt/factorio/bin/x64/factorio --create save.zip
  fi
  factorio_command="$factorio_command --start-server-load-latest"
else
  factorio_command="$factorio_command --start-server $FACTORIO_SAVE"
fi
echo "###"
echo "# Launching Game"
echo "###"
echo "$factorio_command"
exec 0<&-
exec $factorio_command

