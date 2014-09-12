SSHKit::Backend::Netssh.configure do |ssh|
  ssh.connection_timeout = 30
  ssh.ssh_options = {
    keys: [Deploy::Config::CONFIG['public_key_location']],
    forward_agent: false,
    auth_methods: %w(publickey),
    verbose: :debug
  }
end

SSHKit.config.command_map[:rake] = "./bin/rake"