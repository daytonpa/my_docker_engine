#
# Cookbook:: my_docker_engine
# Recipe:: nginx_config
# Author:: Patrick Dayton
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package 'nginx'

service 'nginx' do
  supports [:start, :stop, :restart, :reload]
  action [:start, :enable]
end

cookbook_file '/etc/nginx/nginx.conf' do
  # owner ['my_docker_engine']['user']
  # group ['my_docker_engine']['group']
  owner 'root'
  group 'root'
  mode '0644'
  source 'nginx.conf'
  notifies :restart, 'service[nginx]', :immediately
end
