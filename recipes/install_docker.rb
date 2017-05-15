#
# Cookbook:: my_docker_engine
# Recipe:: install_docker
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#

case node['platform_family']
when 'debian'
  case node['my_docker_engine']['installation_method']
  when 'package'
    apt_package node['my_docker_engine']['install_package']['name'] do
      version node['my_docker_engine']['version']
    end
  when 'repo'
    apt_repository node['my_docker_engine']['install_repo']['name'] do
      uri node['my_docker_engine']['url']
      distribution node['my_docker_engine']['distribution']
      components ['main', 'stable']
      key node['my_docker_engine']['key']
    end
  end

when 'rhel'
  case node['my_docker_engine']['installation_method']
  when 'package'
    yum_package node['my_docker_engine']['install_package']['name'] do
      version node['my_docker_engine']['version']
    end
  when 'repo'
    yum_repository node['my_docker_engine']['install_repo']['name'] do
      description 'Docker Repository'
      baseurl node['my_docker_engine']['url']
      gpgkey node['my_docker_engine']['key']
      action :create
    end
  end
end
