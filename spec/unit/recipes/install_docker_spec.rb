#
# Cookbook:: my_docker_engine
# Spec:: install_docker
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# To run this unit test, copy and paste the command below in your terminal
# chef exec rspec -fd spec/unit/recipes/default_spec.rb --color

require 'spec_helper'

describe 'my_docker_engine::install_docker' do
  # for a complete list of available platforms and versions see:
  # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
  {
    'ubuntu' => ['16.04'],
    'centos' => ['7.2.1511']
  }.each do |os, version|
    version.each do |v|
      context "When installing docker as a package on #{os.upcase}-#{v}" do

        let(:installation_method) { 'package' }

        let(:chef_run) do
          ChefSpec::ServerRunner.new(platform: os, version: v) do |node|
            node.normal['docker_book']['installation_method'] = 'package'
          end.converge(described_recipe)
        end

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end

        case os
        when 'ubuntu'
          it 'installs the Docker apt package, not the apt repo' do
            expect(chef_run).to install_apt_package('docker')
            expect(chef_run).to_not add_apt_repository('docker.io')
          end
        when 'centos'
          it 'installs the Docker yum package, not the yum repo' do
            expect(chef_run).to install_yum_package('docker')
            expect(chef_run).to_not create_yum_repository('docker')
          end
        end
      end

      context "When installing docker from a repository on #{os.upcase}-#{v}" do

        let(:chef_run) do
          ChefSpec::ServerRunner.new(platform: os, version: v) do |node|
            node.normal['my_docker_engine']['installation_method'] = 'repo'
          end.converge(described_recipe)
        end

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end

        case os
        when 'ubuntu'
          it 'downloads the Docker apt repo, not the apt package' do
            expect(chef_run).to add_apt_repository('docker.io')
            expect(chef_run).to_not install_apt_package('docker')
          end
        when 'centos'
          it 'downloads the Docker yum repo, not the yum package' do
            expect(chef_run).to create_yum_repository('docker')
            expect(chef_run).to_not install_yum_package('docker')
          end
        end
      end
    end
  end
end
