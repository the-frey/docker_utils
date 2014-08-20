# Docker Utils

For the quick and dirty shell scripts to start and stop docker containers (build upon these with a combination of pragmatic `sleep` commands and you can orchestrate a surprising amount of docker goodness). Probably best used for prototyping rather than actual production use however.

In the `lib` directory is a small ruby utility that I'll possibly expand on in future. It's a rake task that you can configure some constants for and work with switching out and starting a new container (assuming you're wanting, say, a higher tag number). Works surprisingly smoothly. 

    rake docker:deploy[user,tag]

Note: if you use zsh, you will probably have to write it like so: 

    rake 'docker:deploy[user,tag]'

Note also that the lack of space after the comma is intentional.
