#
# Cookbook:: docker_book
# Spec:: set_up
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# To run this unit test, copy and paste the command below in your terminal
# chef exec rspec -fd spec/unit/recipes/default_spec.rb --color

require 'spec_helper'

describe 'my_docker_engine::set_up' do
  # for a complete list of available platforms and versions see:
  # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
  {
    'ubuntu' => ['16.04'],
    'centos' => ['7.2.1511']
  }.each do |os, version|
    version.each do |v|
      context "When installing prerequisites for Docker on #{os.upcase}-#{v}" do

        let(:chef_run) do
          ChefSpec::ServerRunner.new(platform: os, version: v).converge(described_recipe)
        end

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end

        case os
        when 'ubuntu'
          it 'updates the apt caches' do
            expect(chef_run).to include_recipe('apt')
          end
          it 'installs the required packages for Docker' do
            %w(apt-transport-https ca-certificates curl software-properties-common).each do |pkg|
              expect(chef_run).to install_apt_package(pkg)
            end
          end

        when 'centos'
          it 'updates the yum caches' do
            expect(chef_run).to include_recipe('yum')
          end
          it 'installs the required packages for Docker' do
            expect(chef_run).to install_yum_package('yum-utils')
          end
        end
      end
    end
  end
end
