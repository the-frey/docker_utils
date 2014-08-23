module Deploy
  class Container

    attr_accessor :user, :host, :name, :repo, :tag, :flags

    def initialize(user, host, container_hash)
      self.user = user
      self.host = host
      self.name = container_hash['name']
      self.repo = container_hash['repo']
      self.tag = container_hash['tag']
      self.flags = container_hash['flags']
    end

    # The docker command to run, with flags after CONTAINER_NAME
    def run_command
      output = "docker run -d --name"
      output << " #{self.name}"

      # use splat args to unpack config here
      self.flags.each { |flag| output << " #{flag}" }

      output << " #{self.repo}:#{self.tag}"
      output
    end

  end

  module Config

    CONFIG = YAML.load('../config.yml')
    CONTAINERS = YAML.load('../docker_config.yml')

  end
end