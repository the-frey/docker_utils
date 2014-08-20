#!/bin/bash
 
# Arg 1 is user
# Arg 2 is server
# Arg 3 is password
# Arg 4 is docker command to run
# e.g. ./simpledeploy.sh 'alex' 'build.example.com' 'foo' 'sudo docker run -d --name new-memcached alex/memcached'
# if you wanted to see docker ps at the end of the script, you could do: echo "sudo docker ps" >> ./tmp/deploy_command.sh
 
echo $4 > ./tmp/deploy_command.sh
nohup ssh -t -t $1@$2 "echo $3 | sudo -Sv && bash -s" < ./tmp/deploy_command.sh &
SUCCESS=$?
rm ./tmp/deploy_command.sh
rm ./nohup.out
 
exit $SUCCESS