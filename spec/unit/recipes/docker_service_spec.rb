#
# Cookbook:: my_docker_engine
# Spec:: docker_service
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# To run this unit test, copy and paste the command below in your terminal
# chef exec rspec -fd spec/unit/recipes/docker_service_spec.rb --color
#  OR to run all tests, copy and paste
# chef exec rspec -fd spec/unit/recipes/ --color

require 'spec_helper'

describe 'my_docker_engine::docker_service' do
  # for a complete list of available platforms and versions see:
  # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
  {
    'ubuntu' => ['16.04'],
    'centos' => ['7.2.1511']
  }.each do |os, version|
    version.each do |v|
      context "When creating the Docker service #{os.upcase}-#{v}" do

        let(:chef_run) do
          ChefSpec::ServerRunner.new(platform: os, version: v) do |node|
            node.normal['my_docker_engine']['service']['name'] = 'docker-engine'
          end.converge(described_recipe)
        end

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end

        it 'starts and enables the Docker service' do
          expect(chef_run).to start_service('docker-engine')
          expect(chef_run).to enable_service('docker-engine')
        end
      end
    end
  end
end
