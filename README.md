# Dockistrano

## Getting Started

- Important: you will first will need a deploy user on your server that can access the `docker` command without needing a password.
- Set default and system options in `config.yml`.
- Set your container options in `docker_config.yml`.
- If you do not want loads of logging, be sure to set `debug` to `false` in `config.yml`.

## About 

In the `lib` directory is a small ruby utility. It's driven by a rake task that you can configure using `docker_config.yml` to switch out and start new containers (assuming you're wanting, say, a higher tag number, or different flags). Works surprisingly smoothly. Be careful about committing sensitive information into git.

    rake docker:deploy[user,tag]

Note: if you use zsh, you will probably have to write it like so: 

    rake 'docker:deploy[user,tag]'

Note also that the lack of space after the comma is intentional.

Inspiration in that quarter from Capistrano, more information can be found in their [documentation](https://github.com/capistrano/sshkit/blob/master/EXAMPLES.md). Thanks to lee (Mr. Capistrano) for pointing me in the direction of `sshkit`.

## Config

The config options needed are: 

    default_host: '' # set a default host to use here
    public_key_location: '~/.ssh/id_rsa.pub' # absolute path to public key for your local user - default shown
    default_user: 'deploy' # the user to execute commands as on the server - default shown


## Docker Config YAML Example

Write your container manifest in the order you want them deployed. The first key _must_ be a number, as per the example below. 

### Options

- `stop` should be set to true if a container of the same name already exists on the host and you want it stopped as part of the deploy process.
- Put all flags (e.g. `-v`, `-e`, `--volumes-from`) under a `flags` key.
- `name` is the name you want to assign the container. 
- `repo` is the container image.

    1:
      stop: true
      flags:
        - '-v /var/lib/memcacheddata:/data'
        - "-e FOO='BAR'"
      name: 'memcached-docker'
      repo: 'widgetcorp/memcached'
      tag: '1.2.3'

## TODO

- More tests!
