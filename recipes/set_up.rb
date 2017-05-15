#
# Cookbook:: docker_book
# Recipe:: default
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Update our caches if needed, depending on our OS, and grab some required
# packages
case node['platform_family']
when 'debian'
  include_recipe 'apt'

  # Debian 7 requires the wheezy-backports repository be setup to fully satisfy
  # requirements of the Docker packages.
  include_recipe 'chef-debian' if \
    node['platform'] == 'debian' && \
    node['platform_version'].split('.').first == '7' && \
    node['my_docker_engine']['installation_method'] == 'repo'

  node['my_docker_engine']['req_packages'].each do |pkg|
    apt_package pkg
  end
when 'rhel'
  include_recipe 'yum'

  node['my_docker_engine']['req_packages'].each do |pkg|
    yum_package pkg
  end
end
