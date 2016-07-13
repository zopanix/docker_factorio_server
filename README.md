Factorio
===== 
Factorio Server in docker

Current Version
-----
0.13.8
### What's new ?
#### Factorio
See [factorio's site](http://www.factorio.com)
#### Docker image
* IMPORTANT: Factorio has changed a lot, I've refactored the image

Versions
-----
I'm keeping the image up to date. If you need to use an older version, checkout out the different [tags](https://hub.docker.com/r/zopanix/factorio/tags/).

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
#### Factorio server-settings.json
If you want to use the supplied server-settings.json file to set additional options.
```
docker run -d \
  --env FACTORIO_SERVER_SETTINGS_JSON=true \
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

### Factorio RCON Console Password
This allows you to set a password for RCON (if not specified, it will be random)
```
docker run -d \
  --env FACTORIO_RCON_PASSWORD=[PASSWORD] \
  -p [PORT]:34197/udp \
  zopanix/factorio
```

#### Waiting for ready
This is a beta feature which has nothing to do with factorio... leave it as it is for the moment. I'm working with some collegues on something new which should work very well and please a lot of people.

More to come
