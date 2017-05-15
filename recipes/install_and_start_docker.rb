#
# Cookbook:: my_docker_engine
# Recipe:: install_docker
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#

# Install Docker using the 'docker' cookbook resources and start the service
docker_installation 'docker' do
  action :create
end

docker_service 'default' do
  action [:create, :start]
end
