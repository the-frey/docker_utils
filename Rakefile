$:.unshift File.expand_path(File.dirname(__FILE__))

require 'yaml'
require 'sshkit'
require 'lib/exceptions'
require 'lib/deploy'
require 'lib/sshconfig'

namespace :docker do
  desc "Deploy code to a host. Usage: docker:deploy[jeff,1.2.3]"
  task :deploy, [:user, :host] do |t, args|

    user = args[:user] || Deploy::Config::CONFIG['deploy']
    host = args[:host] || Deploy::Config::CONFIG['default_host']

    on "#{user}@#{host}" do |host|
      
      # loop over docker_config containers
      Deploy::Config::CONTAINERS.each do |c|

        container = Deploy::Container.new(user, host, c)

        execute :sudo, "docker pull #{container.repo}:#{container.tag}"
        execute :sudo, "docker stop #{container.name}" if c[:stop] == true
        execute :sudo, "docker rm #{container.name}"
        execute :sudo, "#{container.run_command}"

      end

    end

  end
end