#
# Cookbook:: my_docker_engine
# Recipe:: default
# Author:: Patrick Dayton
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# This recipe will act as a smart run-list.  It will determine the best method
# for installing Docker based on installation preferences set in the attributes
# file and operating system.

case node['platform_family']
when 'debian', 'rhel'
  include_recipe 'my_docker_engine::set_up'
  include_recipe 'my_docker_engine::nginx_conf'
  include_recipe 'my_docker_engine::install_and_start_docker'
  include_recipe 'my_docker_engine::build_containers'
else
  log 'Unsupported Platform' do
    level :info
    message 'Sorry... that OS is not supported by this cookbook at this time.'\
      'Please refer to the README.md for more information regarding supported'\
      'platforms.'
  end
end
