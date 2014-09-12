$:.unshift File.expand_path(File.dirname(__FILE__))

require 'yaml'
require 'sshkit'
require 'sshkit/dsl'
require 'lib/exceptions'
require 'lib/deploy'
require 'lib/sshconfig'

namespace :docker do
  desc "Deploy code to a host. Usage: docker:deploy[jeff,1.2.3]"
  task :deploy, [:user, :host] do |t, args|

    user = args[:user] || Deploy::Config::CONFIG['default_user']
    host = args[:host] || Deploy::Config::CONFIG['default_host']

    on "#{user}@#{host}" do |host|
      
      # loop over docker_config containers
      Deploy::Config::CONTAINERS.each_with_index do |c, i|

        puts "-> Deploying container #{c}..."

        container_number = i + 1
        current_container_hash = Deploy::Config::CONTAINERS[container_number]
        container = Deploy::Container.new(user, host, current_container_hash)

        execute :sudo, "docker pull #{container.repo}:#{container.tag}"

        if current_container_hash["stop"] == true
          execute :sudo, "docker stop #{container.name}"
          execute :sudo, "docker rm #{container.name}"
        end
        
        execute :sudo, "#{container.run_command}"

      end

    end

  end
end