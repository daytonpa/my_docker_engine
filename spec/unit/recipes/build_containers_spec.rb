#
# Cookbook:: my_docker_engine
# Spec:: build_containers
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#

require 'spec_helper'

describe 'my_docker_engine::build_containers' do
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

        it 'creates and saves the listed Docker images' do
          expect(chef_run).to pull_docker_image('hello-world').with(
            tag: 'latest'
          )
          expect(chef_run).to save_docker_image('hello-world')
        end

        it 'builds the listed Docker containers' do
          expect(chef_run).to build_docker_container('my_hello-world').with(
            repo: 'hello-world',
            tag: 'latest',
            port: '80:80'
          )
        end
      end
    end
  end
end
