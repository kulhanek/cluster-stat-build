# wolf-stat-server-build
Utilities for testing and building of the [wolf-stat-server](https://github.com/kulhanek/wolf-stat-server) package.

## Building and Installation

### Production Build
```bash
$ git clone --recursive https://github.com/kulhanek/wolf-stat-server-build.git
$ cd wolf-stat-server-build
$ ./build-utils/00.init-links.sh
$ ./01.pull-code.sh
$ ./10.build-final.sh       # install dir: /opt/wolf-stat-server/2.0
```


