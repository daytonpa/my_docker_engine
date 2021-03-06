#
# Cookbook:: my_docker_engine
# Spec:: install_docker
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# To run this unit test, copy and paste the command below in your terminal
# chef exec rspec -fd spec/unit/recipes/default_spec.rb --color
#  OR to run all tests, copy and paste
# chef exec rspec -fd spec/unit/recipes/ --color

require 'spec_helper'

describe 'my_docker_engine::default' do
  # for a complete list of available platforms and versions see:
  # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
  {
    'ubuntu' => ['16.04'],
    'centos' => ['7.2.1511']
  }.each do |os, version|
    version.each do |v|
      context "When installing/configuring Docker on #{os.upcase}-#{v}" do

        let(:chef_run) do
          ChefSpec::ServerRunner.new(platform: os, version: v).converge(described_recipe)
        end

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end

        case os
        when 'ubuntu', 'centos'
          it 'includes the set_up, install_and_start_docker, and build_containers recipes' do
            %w( set_up install_and_start_docker build_containers ).each do |recipe|
              expect(chef_run).to include_recipe("my_docker_engine::#{recipe}")
              expect(chef_run).to_not write_log('Unsupported Platform')
            end
          end
        else
          it 'notifies that your platform is not supported' do
            expect(chef_run).to write_log('Unsupported Platform').with(
              level: :info
            )
          end
        end
      end
    end
  end
end
