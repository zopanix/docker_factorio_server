Factorio
===== 
Factorio Server in docker

Current Version
-----
0.12.29
### What's new ?
#### Factorio
[factorio's site](http://www.factorio.com)
#### Docker image

Versions
-----
I'm keeping the image up to date. If you need to use an older version, checkout out the different tags.

How to use ?
-----
3 ways of launching it :
* Without map persistence
* With map persistence
* With existing map

### Without map persistence
Here is the command :
`docker run -d -p [PORT]:34197/udp factorio`
This will generate a new random map with default settings.
If you're going to launch it on your local machine, don't use the port 34197, take another one at random.

### With map persistence
`docker run -d -v [PATH]:/opt/factorio/saves -p [PORT]:34197/udp factorio`
This will generate a new random map with default settings and save it onto the volume.
Replace [PATH] with a path to a folder on the host where the map will be saved.

### With existing map
`docker run -d -v [PATH]:/opt/factorio/saves -p [PORT]:34197/udp factorio`
It's the same as above, so if there is a file named save.zip in the [PATH] folder, it will use that map as default.
