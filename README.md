Factorio
===== 
Factorio Server in docker

Current Version
-----
0.12.29
### What's new ?
#### Factorio
See [factorio's site](http://www.factorio.com)
#### Docker image
* Automatically takes latest save or autosave. when restarting the container.
* Added possibility to change defautl autosave interval

Versions
-----
I'm keeping the image up to date. If you need to use an older version, checkout out the different [tags](https://hub.docker.com/r/zopanix/factorio/tags/).

How to use ?
-----
3 ways of launching it :
* Without map persistence
* With map persistence
* With existing map

### Without map persistence
Here is the command :
`docker run --rm -d -p [PORT]:34197/udp zopanix/factorio`
This will generate a new random map with default settings.
If you're going to launch it on your local machine, don't use the port 34197, take another one at random.

### With map persistence
`docker run --rm -d -v [PATH]:/opt/factorio/saves -p [PORT]:34197/udp zopanix/factorio`
This will generate a new random map with default settings and save it onto the volume.
Replace [PATH] with a path to a folder on the host where the map will be saved.

### With existing map
`docker run --rm -d -v [PATH]:/opt/factorio/saves -p [PORT]:34197/udp zopanix/factorio`
It's the same as above, it takes the last modified file which contains the word save in the filename as current save when booting the server. This allows when upgrading the container to take the last save, you don't have to rename the last autosave as save.zip

### Advanced usage
#### Autosave interval
You can set the autosave interval. By default it is set at 2 minutes bud you can change it by launching the container with the "FACTORIO_AUTOSAVE_INTERVAL" variable to whatever suits you best.
`docker run --rm -d --env FACTORIO_AUTOSAVE_INTERVAL=[NUMBER] -v [PORT]:34197/udp  zopanix/factorio`
Where [NUMBER] is the number of minutes between autosaves. 
#### Autosave slots
You can set the number of autosave slots. By default it is set at 3 slots bud you can change it by launching the container with the "FACTORIO_AUTOSAVE_SLOTS" variable to whatever suits you best.
`docker run --rm -d --env FACTORIO_AUTOSAVE_SLOTS=[NUMBER] -v [PORT]:34197/udp  zopanix/factorio`
Where [NUMBER] is the number of autosave slots.  

ToDo's :
-----
* Adding possibility to add a mod volume
