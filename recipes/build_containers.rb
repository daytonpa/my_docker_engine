#
# Cookbook:: my_docker_engine
# Recipe:: build_containers
# Author:: Patrick Dayton
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#

# Create and save the base images for Docker, and then create containers from
# those images

directory 'docker' do
  user node['my_docker_engine']['user']
  group node['my_docker_engine']['group']
  mode '0644'
  action :create
end

repo_name = 'hello-cow'
git "/docker/#{repo_name}" do
  repository "git://github.com/docnetwork/#{repo_name}.git"
  revision 'master'
  action :sync
end

node['my_docker_engine']['dockerfiles'].each do |df|

  cookbook_file "/docker/hello-cow/Dockerfile.#{df}" do
    user node['my_docker_engine']['user']
    group node['my_docker_engine']['group']
    mode '0644'

    source "Dockerfile.#{df}"
    action :create
  end

  execute 'create_docker_image' do
    cwd '/docker/hello-cow'
    user node['my_docker_engine']['user']
    group node['my_docker_engine']['group']
    command "docker build -t #{df} . --file Dockerfile.#{df}"

    not_if "test docker images | grep #{df}"
  end
end

image_name = 'cowsay'
container_name = image_name + '_container'
execute 'start_container' do
  cwd '/docker/hello-cow'
  user node['my_docker_engine']['user']
  group node['my_docker_engine']['group']
  command "docker run -p #{node['my_docker_engine']['ip_address']}:8080:8080 --name #{container_name} #{image_name}"

  not_if "test docker ps | grep #{container_name}"
end
