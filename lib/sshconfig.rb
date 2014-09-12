VERBOSE_SSH_LOGGING = Deploy::Config::CONFIG['debug'] == true ? :debug : false

SSHKit::Backend::Netssh.configure do |ssh|
  ssh.connection_timeout = 30
  ssh.ssh_options = {
    keys: [Deploy::Config::CONFIG['public_key_location']],
    forward_agent: false,
    auth_methods: %w(publickey),
    verbose: VERBOSE_SSH_LOGGING
  }
end

SSHKit.config.command_map[:rake] = "./bin/rake"