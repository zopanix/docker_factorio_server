Factorio [![Build Status](https://travis-ci.org/zopanix/docker_factorio_server.svg?branch=master)](https://travis-ci.org/zopanix/docker_factorio_server)  [![Docker Pulls](https://img.shields.io/docker/pulls/zopanix/factorio.svg?maxAge=2592000)](https://hub.docker.com/r/zopanix/factorio/)
===== 
Factorio Server in docker

Versions
-----
Please checkout the different [tags](https://hub.docker.com/r/zopanix/factorio/tags/)

### What's new ?
#### Factorio
See [factorio's site](http://www.factorio.com)
#### Docker image
* New semver for version !!!Tags have changed now!!!
* Automated build with travis 


How to use ?
-----

### I just want to play !
This runs factorio with default settings, and your save will be kept :
```
docker run -d \
  -v [PATH]:/opt/factorio/saves \
  -p [PORT]:34197/udp \
  zopanix/factorio
```
* Where [PATH] is a folder where you'll put your saves, if there already is a save in it with the string "save", that one will be taken by default, otherwize, a new one will be made.
* Where [PORT] is the port number you choose, if you're going to launch it on your local machine, don't use the port 34197, take another one at random.

### Advanced usage
#### Without map persistence
```
docker run -d \
  -p [PORT]:34197/udp \
  zopanix/factorio
```
This will generate a new random map with default settings.

#### With map persistence
```
docker run -d \
  -v [PATH]:/opt/factorio/saves \
  -p [PORT]:34197/udp \
  zopanix/factorio
```
This will generate a new random map with default settings and save it onto the volume.
Replace [PATH] with a path to a folder on the host where the map will be saved. If existing saves exist it will take the latest one.

#### Autosave interval
You can set the autosave interval. By default it is set at 2 minutes bud you can change it by launching the container with the "FACTORIO_AUTOSAVE_INTERVAL" variable to whatever suits you best.
```
docker run -d \
  --env FACTORIO_AUTOSAVE_INTERVAL=[NUMBER] \
  -p [PORT]:34197/udp  \
  zopanix/factorio
```
Where [NUMBER] is the number of minutes between autosaves. 

#### Autosave slots
You can set the number of autosave slots. By default it is set at 3 slots bud you can change it by launching the container with the "FACTORIO_AUTOSAVE_SLOTS" variable to whatever suits you best.
```
docker run -d \
  --env FACTORIO_AUTOSAVE_SLOTS=[NUMBER] \
  -p [PORT]:34197/udp  \
  zopanix/factorio
```
Where [NUMBER] is the number of autosave slots.  

#### Mounting mod volume
As everybody knows about factorio is you can add mods to it. Now you can also do it in this docker image by mounting a volume.
```
docker run -d \
  -v [PATH]:/opt/factorio/mods \
  -p [PORT]:34197/udp \
  zopanix/factorio
```
Where [PATH] is the path to the folder with your mods.

#### Allowing in-game commands
I've always disabled in-game commands because I think it is like cheating, however, you can enable them by setting the the "FACTORIO_ALLOW_COMMANDS" variable to "true".
```
docker run -d \
  --env FACTORIO_ALLOW_COMMANDS=true \
  -p [PORT]:34197/udp \
  zopanix/factorio
```

#### Activating no-auto-pause in the game when no one is on the server
I do not recommend this feature, bud it can make the game more difficult if you're up for a challenge :-). Just set the "FACTORIO_NO_AUTO_PAUSE" variable to "true".
```
docker run -d \
  --env FACTORIO_NO_AUTO_PAUSE=true \
  -p [PORT]:34197/udp \
  zopanix/factorio
```

#### Change latency option
I do not know what the real impact is, ut has always worked very well on default, but you can change the latency option in ms.
```
docker run -d \
  --env FACTORIO_LATENCY_MS=[number] \
  -p [PORT]:34197/udp \
  zopanix/factorio
```

#### Factorio Mode
I don't know what it is, possibilities are : heavy, complete or none (don't do anything...)
```
docker run -d \
  --env FACTORIO_MODE=[MODE] \
  -p [PORT]:34197/udp \
  zopanix/factorio
```

#### Factorio Server Name
Set Factorio Server Name (defaults to "Factorio Server")
```
docker run -d \
  --env FACTORIO_SERVER_NAME=[NAME]
  -p [PORT]:34197/udp \
  zopanix/factorio
```

#### Factorio Server Description
Set Factorio Server Description (if not specified, no description will be set)
```
docker run -d \
  --env FACTORIO_SERVER_DESCRIPTION=[DESCRIPTION]
  -p [PORT]:34197/udp \
  zopanix/factorio
```

#### Factorio Server Max Players
Set Factorio Server Max Players count (if not specified, maximum players is set to 255)
```
docker run -d \
  --env FACTORIO_SERVER_MAX_PLAYERS=[NUMBER]
  -p [PORT]:34197/udp \
  zopanix/factorio
```

#### Factorio Server Visibility
[//]: # (Set Factorio Server Visibility (if set to public, factorio.com User Login and Password or Token are required))
Set Factorio Server Visibility (if set to public, factorio.com User Login and Password are required)
```
docker run -d \
  --env FACTORIO_SERVER_VISIBILITY=[hidden,lan,public]
  -p [PORT]:34197/udp \
  zopanix/factorio
```

#### Factorio Server factorio.com Login
[//]: # (Set factorio.com User Login and Password or Token required for public server visibility)
[//]: # (  --env FACTORIO_USER_TOKEN=[TOKEN])
Set factorio.com User Login and Password required for public server visibility
```
docker run -d \
  --env FACTORIO_USER_USERNAME=[USERNAME]
  --env FACTORIO_USER_PASSWORD=[PASSWORD]
  -p [PORT]:34197/udp \
  zopanix/factorio
```

#### Factorio Server Game Password
Set Factorio Server Game Password (if not specified, no password will be set)
```
docker run -d \
  --env FACTORIO_SERVER_GAME_PASSWORD=[GAME-PASSWORD]
  -p [PORT]:34197/udp \
  zopanix/factorio
```

#### Factorio Server Verify User Identity
Set Verify User Identity to true to require factorio.com account for user to login (defaults to false)
```
docker run -d \
  --env FACTORIO_SERVER_VERIFY_IDENTITY=[false,true]
  -p [PORT]:34197/udp \
  zopanix/factorio
```

#### Factorio RCON Console Port
This allows you to expose a RCON Console
```
docker run -d \
  -p [PORT]:34197/udp \
  -p [PORT_RCON]:27015/tcp \
  zopanix/factorio
```
Where PORT_RCON is the port you want to use.
By default a random password is set bud ... see below

#### Factorio RCON Console Password
This allows you to set a password for RCON (if not specified, it will be random)
```
docker run -d \
  --env FACTORIO_RCON_PASSWORD=[PASSWORD] \
  -p [PORT]:34197/udp \
  zopanix/factorio
```

#### Authorization Error
If your container exits with the following error:
```
Info HttpSharedState.cpp:83: Status code: 401
Info AuthServerConnector.cpp:40: Error in communication with auth server: code(401) message({
  "message": "Username and password don't match",
  "status": 401
})
Info AuthServerConnector.cpp:68: Auth server authorization error (Username and password don't match)
Error Util.cpp:57: Unknown error
```
Check supplied Username and Password for mistakes.

#### Waiting for ready
This is a beta feature which has nothing to do with factorio... leave it as it is for the moment. I'm working with some collegues on something new which should work very well and please a lot of people.

More to come
