#
# Cookbook:: my_docker_engine
# Recipe:: config_docker
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Create a new directory for the configuration of Docker
directory node['my_docker_engine']['conf_dir'] do
  owner node['my_docker_engine']['user']
  group node['my_docker_engine']['group']
  mode '0755'
end

file node['my_docker_engine']['conf_dir'] + '/daemon.json' do
  owner node['my_docker_engine']['user']
  group node['my_docker_engine']['group']
  mode '0644'
end
