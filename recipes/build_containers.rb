#
# Cookbook:: my_docker_engine
# Recipe:: build_containers
# Author:: Patrick Dayton
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#

# Create and save the base images for Docker, and then create containers from
# those images

node['my_docker_engine']['docker_images'].each do |dimg|
  docker_image dimg do
    tag 'latest'
    action [:pull, :save]
    destination "/tmp/#{dimg}.tar"
    notifies :redeploy, 'docker_container[my_hello-world]'
    not_if { ::File.exist?("/tmp/#{dimg}.tar") }
  end
end

# We can do a role search here to properly assign images to their respective
# containers.  For now, we will load a default 'hello-world' image.

docker_container 'my_hello-world' do
  repo 'hello-world'
  tag 'latest'
  port '80:80'
end
