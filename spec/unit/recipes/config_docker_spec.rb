#
# Cookbook:: my_docker_engine
# Spec:: config_docker
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# To run this unit test, copy and paste the command below in your terminal
# chef exec rspec -fd spec/unit/recipes/config_docker_spec.rb --color
#  OR to run all tests, copy and paste
# chef exec rspec -fd spec/unit/recipes/ --color


require 'spec_helper'

describe 'my_docker_engine::config_docker' do
  # for a complete list of available platforms and versions see:
  # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
  {
    'ubuntu' => ['16.04'],
    'centos' => ['7.2.1511']
  }.each do |os, version|
    version.each do |v|
      context "When configuring Docker on #{os.upcase}-#{v}" do

        let(:user) { 'root' }
        let(:group) { 'root' }
        
        let(:chef_run) do
          ChefSpec::ServerRunner.new(platform: os, version: v) do |node|
            node.normal['my_docker_engine']['user'] = user
            node.normal['my_docker_engine']['group'] = group
          end.converge(described_recipe)
        end

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end

        it 'creates a configuration directory for Docker' do
          expect(chef_run).to create_directory('/etc/docker').with(
            owner: user,
            group: group,
            mode: '0755'
          )
        end

        it 'generates the `daemon.json` configuration file' do
          expect(chef_run).to create_file('/etc/docker/daemon.json').with(
            owner: user,
            group: group,
            mode: '0644'
          )
        end
      end
    end
  end
end
