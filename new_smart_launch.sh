#!/bin/bash
echo '      ___         ___           ___                       ___           ___                       ___     '
echo '     /  /\       /  /\         /  /\          ___        /  /\         /  /\        ___          /  /\    '
echo '    /  /:/_     /  /::\       /  /:/         /  /\      /  /::\       /  /::\      /  /\        /  /::\   '
echo '   /  /:/ /\   /  /:/\:\     /  /:/         /  /:/     /  /:/\:\     /  /:/\:\    /  /:/       /  /:/\:\  '
echo '  /  /:/ /:/  /  /:/~/::\   /  /:/  ___    /  /:/     /  /:/  \:\   /  /:/~/:/   /__/::\      /  /:/  \:\ '
echo ' /__/:/ /:/  /__/:/ /:/\:\ /__/:/  /  /\  /  /::\    /__/:/ \__\:\ /__/:/ /:/___ \__\/\:\__  /__/:/ \__\:\'
echo ' \  \:\/:/   \  \:\/:/__\/ \  \:\ /  /:/ /__/:/\:\   \  \:\ /  /:/ \  \:\/:::::/    \  \:\/\ \  \:\ /  /:/'
echo '  \  \::/     \  \::/       \  \:\  /:/  \__\/  \:\   \  \:\  /:/   \  \::/~~~~      \__\::/  \  \:\  /:/ '
echo '   \  \:\      \  \:\        \  \:\/:/        \  \:\   \  \:\/:/     \  \:\          /__/:/    \  \:\/:/  '
echo '    \  \:\      \  \:\        \  \::/          \__\/    \  \::/       \  \:\         \__\/      \  \::/   '
echo '     \__\/       \__\/         \__\/                     \__\/         \__\/                     \__\/    '
# Checking if server is ready 
if [ $FACTORIO_WAITING == true ] 
then 
  until [ -f /opt/factorio/saves/ready ] 
  do 
    echo "# Waiting for backup daemon to be ready" 
    sleep 1 
  done 
fi
# Include server-settings.json if one or more variables are populated
if [ "$FACTORIO_SERVER_NAME" ] \
|| [ "$FACTORIO_SERVER_DESCRIPTION" ] \
|| [ "$FACTORIO_SERVER_MAX_PLAYERS" ] \
|| [ "$FACTORIO_SERVER_VISIBILITY" ] \
|| [ "$FACTORIO_USER_USERNAME" ] \
|| [ "$FACTORIO_USER_PASSWORD" ] \
|| [ "$FACTORIO_USER_TOKEN" ] \
|| [ "$FACTORIO_SERVER_GAME_PASSWORD" ] \
|| [ "$FACTORIO_SERVER_VERIFY_IDENTITY" ]
then
  factorio_command="$factorio_command --server-settings /opt/factorio/server-settings.json"
  # Set Server Name default value if not set by user param
  if [ -z "$FACTORIO_SERVER_NAME" ]
  then
    FACTORIO_SERVER_NAME="Factorio Server"
  fi
  # Set Visibility default value if not set by user param
  if [ -z "FACTORIO_SERVER_VISIBILITY" ]
  then
    FACTORIO_SERVER_VISIBILITY="hidden"
  fi
  # Set Verify User Identity default value if not set by user param
  if [ -z "FACTORIO_SERVER_VERIFY_IDENTITY" ]
  then
    FACTORIO_SERVER_VERIFY_IDENTITY="false"
  fi
  # Check for supplied credentials if visibility is set to public
  if [ "FACTORIO_SERVER_VISIBILITY" == "public" ]
  then
    if [ -z "FACTORIO_USER_USERNAME" ]
    then
      echo "Server Visibility is set to public but no factorio.com Username is supplied!"
      echo "Defaulting back to Server Visibility: hidden"
    fi
    if [ "FACTORIO_USER_USERNAME" ]
    then
      if [ -z "FACTORIO_USER_PASSWORD" ] && [ -z "FACTORIO_USER_TOKEN" ]
      then
      echo "Server Visibility is set to public but no factorio.com Password or Token is supplied!"
      echo "Defaulting back to Server Visibility: hidden"
      fi
    fi
  fi
fi
# Populate server-settings.json
SERVER_SETTINGS=/opt/factorio/server-settings.json
cat << EOF > $SERVER_SETTINGS
{
"name": "$FACTORIO_SERVER_NAME",
"description": "$FACTORIO_SERVER_DESCRIPTION",
"max_players": "$FACTORIO_SERVER_MAX_PLAYERS",

"_comment_visibility": ["public: Game will be published on the official Factorio matching server",
                        "lan: Game will be broadcast on LAN",
                        "hidden: Game will not be published anywhere"],
"visibility": "$FACTORIO_SERVER_VISIBILITY",

"_comment_credentials": "Your factorio.com login credentials. Required for games with visibility public",
"username": "$FACTORIO_USER_USERNAME",
"password": "$FACTORIO_USER_PASSWORD",

"_comment_token": "Authentication token. May be used instead of 'password' above.",
"token": "$FACTORIO_USER_TOKEN",

"game_password": "$FACTORIO_SERVER_GAME_PASSWORD",

"_comment_verify_user_identity": "When set to true, the server will only allow clients that have a valid Factorio.com account",
"verify_user_identity": $FACTORIO_SERVER_VERIFY_IDENTITY
}
EOF
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
# Show server-settings.json config
if [ "$FACTORIO_SERVER_NAME" ] \
|| [ "$FACTORIO_SERVER_DESCRIPTION" ] \
|| [ "$FACTORIO_SERVER_MAX_PLAYERS" ] \
|| [ "$FACTORIO_SERVER_VISIBILITY" ] \
|| [ "$FACTORIO_USER_USERNAME" ] \
|| [ "$FACTORIO_USER_PASSWORD" ] \
|| [ "$FACTORIO_USER_TOKEN" ] \
|| [ "$FACTORIO_SERVER_GAME_PASSWORD" ] \
|| [ "$FACTORIO_SERVER_VERIFY_IDENTITY" ]
then
  echo "###"
  echo "# Server Config:"
  echo "# Server Name = '$FACTORIO_SERVER_NAME'"
  echo "# Server Description = '$FACTORIO_SERVER_DESCRIPTION'"
  echo "# Server Password = '$FACTORIO_SERVER_GAME_PASSWORD'"
  echo "# Max Players = '$FACTORIO_SERVER_MAX_PLAYERS'"
  echo "# Server Visibility = '$FACTORIO_SERVER_VISIBILITY'"
  echo "# Verify User Identify = '$FACTORIO_SERVER_VERIFY_IDENTITY'"
  echo "# Factorio Username = '$FACTORIO_USER_USERNAME'"
  echo "# Factorio Password = '$FACTORIO_USER_PASSWORD'"
  echo "# Factorio User Token = '$FACTORIO_USER_TOKEN'"
  echo "###"
fi
# TODO Adding this because of bug, will need to be removed once bug in factorio is fixed
cd /opt/factorio/saves
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
# Closing stdin
exec 0<&-
exec $factorio_command
