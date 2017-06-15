#
# Cookbook:: my_docker_engine
# Attributes:: default
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#

default['my_docker_engine'].tap do |dock|

  dock['user'] = 'root'
  dock['group'] = 'root'

  # Required packages
  case node['platform_family']
  when 'debian'
    dock['req_packages'] = %w(
      apt-transport-https ca-certificates curl software-properties-common
    )
  when 'rhel'
    dock['req_packages'] = %w(
      yum-utils
    )
  end

  # Docker package name
  dock['install_package']['version'] = '1.5-1'

  # Docker repo and package names
  case node['my_docker_engine']['installation_method']
  when 'package'
    dock['installation']['name'] = 'docker.io'
  end

  dock['service']['name'] = 'docker'
  dock['conf_dir'] = '/etc/docker'
  dock['components'] = ['main', 'stable']
  dock['distribution'] = "#{node['platform']}-#{node['lsb']['codename']}"

  # Default Docker image
  dock['dockerfiles'] = %w(cowsay nodejs_server)

  # Configuration options
  dock['ip_address'] = '127.0.0.1'
  dock['config'] = nil

end
