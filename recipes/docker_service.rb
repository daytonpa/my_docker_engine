#
# Cookbook:: my_docker_engine
# Recipe:: docker_service
# Author:: Patrick Dayton
#
# Copyright:: 2017, The Authors, All Rights Reserved.

execute 'unmask_docker' do
  user node['my_docker_engine']['user']
  group node['my_docker_engine']['group']
  command <<-EOD
    systemctl unmask docker.service
    systemctl unmask docker.socket
  EOD

end

service node['my_docker_engine']['service']['name'] do
  supports status: true, reload: true
  action [:start, :enable]
  subscribes :restart, 'file[/etc/docker/daemon.json]', :immediately
end
