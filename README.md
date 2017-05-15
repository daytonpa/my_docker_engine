# my_docker_engine

#### Description
This cookbook will install and configure Docker.  This is also still in development, but more is to come!  So far, Docker is installed, creates a 'hello-world' container, and runs the service.  You can view the container by entering ```0.0.0.0:80``` in your browser after converging.

#### Supported platforms
 - ubuntu 16.04
 - centos 7.2
 - (more platforms will be tested later)

#### Cookbook dependencies
 - docker
 - apt
 - yum

#### Usage
There are a few attributes you can set that will install Docker for you.  By default, the attribute ```node['my_docker_engine']['installation_method']``` is set to ```'package'```.  If you would like to install Docker via downloading the repository, change that attribute to ```'repo'``` in either the ```.kitchen.yml```, or within the default attributes file.

#### Recipes
 - ```default```: This recipe acts as a smart run-list for installing Docker.  It will check to verify your desired OS is supported by this cookbook, and then continues through the set up of installation/configuration.  If your platform is not supported, Chef will notify you that you are using an "Unsupported Platform"

 - ```set_up```: Updates the apt or yum caches (depending on desired OS) and installs the required 3rd-party packages for running Docker.

 - ```install_and_start_docker```: Install Docker and create/start the service.

 - ```build_containers```: Creates the base images for your docker containers, and then builds the containers

#### Unit Tests
All unit tests are performed by ChefSpec on each recipe.  Currently, the unit tests will test on Ubuntu 16.04 and CentOS 7.2.
