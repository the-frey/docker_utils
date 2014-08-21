require 'sshkit/dsl'

module Deploy
  class Config

    attr_accessor :user, :tag

    def initialize(user, tag)
      self.user = user
      self.tag = tag
    end

    # The docker command to run, with flags after CONTAINER_NAME
    def run_command
      output = "docker run -d --name" 
      output << " #{Deploy::Config::CONTAINER_NAME}" 
      output << " " #=> place extra flags here
      output << " #{Deploy::Config::DOCKER_REPO}:#{self.tag}"
      output
    end

    # Set these
    DOCKER_REPO = '' # e.g. widgetcorp/memcached
    CONTAINER_NAME = '' # e.g. memcached
    HOST = '' # e.g. build.example.com
    PUBLIC_KEY_LOCATION = '~/.ssh/id_rsa.pub'

  end
end

SSHKit::Backend::Netssh.configure do |ssh|
  ssh.connection_timeout = 30
  ssh.ssh_options = {
    keys: [Deploy::Config::PUBLIC_KEY_LOCATION],
    forward_agent: false,
    auth_methods: %w(publickey),
    verbose: :debug
  }
end

SSHKit.config.command_map[:rake] = "./bin/rake"

namespace :docker do
  desc "Deploy code to a host. Usage: docker:deploy[jeff,1.2.3]"
  task :deploy, [:user, :tag] do |t, args|

    tag = args[:tag] || 'latest' 
    user = args[:user] || 'no user supplied!'
    config = Deploy::Config.new(user, tag)

    on "#{config.user}@#{Deploy::Config::HOST}" do |host|

      execute :sudo, "docker pull #{Deploy::Config::DOCKER_REPO}:#{config.tag}"
      execute :sudo, "docker stop #{Deploy::Config::CONTAINER_NAME}"
      execute :sudo, "docker rm #{Deploy::Config::CONTAINER_NAME}"
      execute :sudo, "#{config.run_command}"

    end

  end
end
