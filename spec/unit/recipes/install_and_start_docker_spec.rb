#
# Cookbook:: my_docker_engine
# Spec:: install_docker
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# To run this unit test, copy and paste the command below in your terminal
# chef exec rspec -fd spec/unit/recipes/default_spec.rb --color

require 'spec_helper'

describe 'my_docker_engine::install_and_start_docker' do
  # for a complete list of available platforms and versions see:
  # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
  {
    'ubuntu' => ['16.04'],
    'centos' => ['7.2.1511']
  }.each do |os, version|
    version.each do |v|
      context "When installing Docker on #{os.upcase}-#{v}" do

        let(:chef_run) do
          ChefSpec::ServerRunner.new(platform: os, version: v).converge(described_recipe)
        end

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end
        it 'installs Docker' do
          expect(chef_run).to create_docker_installation('docker')
        end
        it 'creates and starts the docker service' do
          expect(chef_run).to create_docker_service('default')
          expect(chef_run).to start_docker_service('default')
        end
      end
    end
  end
end
