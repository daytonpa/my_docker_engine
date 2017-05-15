require 'chefspec'
require 'chefspec/berkshelf'

if defined?(ChefSpec)
  def create_docker_installation(name)
    ChefSpec::Matchers::ResourceMatcher.new(:docker_installation, :create, name)
  end
  def create_docker_service(name)
    ChefSpec::Matchers::ResourceMatcher.new(:docker_service, :create, name)
  end
  def start_docker_service(name)
    ChefSpec::Matchers::ResourceMatcher.new(:docker_service, :start, name)
  end
  def build_docker_container(name)
    ChefSpec::Matchers::ResourceMatcher.new(:docker_container, :run, name)
  end
  def save_docker_container(name)
    ChefSpec::Matchers::ResourceMatcher.new(:docker_container, :save, name)
  end
end
