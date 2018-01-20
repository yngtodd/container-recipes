# Creating base containers

To create a docker base container the following steps must be preformed

- Run `TitanLib.sh` on Titan to produce `titan_lib.tar.gz`
- Commit `titan_lib.tar.gz` to the repo so a history is maintained of the libraries used
- Clone this repo to the build host
  - the build host must have docker build capabilities
- Build the container 
  - `docker build -t code.ornl.gov:4567/olcf/container-recipes/{system}/{distro}_{version}:{yyyy-mm-dd} .`
  - e.g. `docker build -t code.ornl.gov:4567/olcf/container-recipes/Titan/Ubuntu_17.04:2018-01-30 .`
- Push to the registry `docker push code.ornl.gov:4567/olcf/container-recipes`