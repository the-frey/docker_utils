#!/bin/bash

# Arg 1 is user
# Arg 2 is server
# Arg 3 is password
# Arg 4 is docker to stop
# e.g. ./stop_docker.sh 'alex' 'build.example.com' 'foo' 'rails-app'

echo "sudo docker stop $4 && sudo docker rm $4" > ./tmp/status_command.sh

nohup ssh -t -t $1@$2 "echo $3 | sudo -Sv && bash -s" < ./tmp/status_command.sh &

SUCCESS=$?

rm ./tmp/status_command.sh

# We want to be certain that all containers have time to exit
echo "Stopping containers, please be patient..."
sleep 8

awk '1' ./nohup.out
rm ./nohup.out
 
exit $SUCCESS