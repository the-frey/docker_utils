#!/bin/bash
 
# Arg 1 is user
# Arg 2 is server
# Arg 3 is password
# e.g. ./docker_status.sh 'alex' 'build.example.com' 'foo'
 
echo 'sudo docker ps' > ./tmp/status_command.sh

nohup ssh -t -t $1@$2 "echo $3 | sudo -Sv && bash -s" < ./tmp/status_command.sh &

SUCCESS=$?

rm ./tmp/status_command.sh

# give it time for the program to finish executing
sleep 5

awk '1' ./nohup.out
rm ./nohup.out
 
exit $SUCCESS