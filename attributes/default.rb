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

  # Choose your desired Docker installation method.  You may pick 'package'
  # or 'repo'.
  # Default is set to 'package'
  dock['installation_method'] = 'package'

  # case node['platform_family']
  # when 'debian'
  #   dock['url'] = 'https://apt.dockerproject.org/repo'
  #   dock['key'] = 'https://apt.dockerproject.org/gpg'
  # when 'rhel'
  #   plat_v = node['platform_version'].split('.').first
  #   dock['url'] = "https://yum.dockerproject.org/repo/main/centos/#{plat_v}/"
  #   dock['key'] = 'https://yum.dockerproject/gpg'
  # end

  # Default Docker image
  dock['docker_images'] = ['hello-world']

  # Configuration options
  dock['config'] = nil

end
