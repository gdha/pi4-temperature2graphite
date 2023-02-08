#!/bin/sh

# As this script runs on Alpine (busybox) we cannot use bash syntax
#set -e
POD=$(echo $HOSTNAME)
HOSTNAME=$(cat /etc/hostname)
#SERVER=$(/usr/local/bin/kubectl -n graphite describe pod graphite-0 | grep -i node: | cut  -d/ -f2)
while true
do
  # move the SERVER line inside the loop as at each restart the graphite pod gets a new IP address
  SERVER=$(/usr/bin/kubectl -n graphite get pods -o wide | tail -1 | awk '{print $6}')
  cpu_temp=$(cat /sys/class/thermal/thermal_zone0/temp)
  #cpu_temp=$(($cpu_temp/1000))
  cpu_temp=$(expr $cpu_temp / 1000)
  echo "carbon.celsius.$HOSTNAME $cpu_temp $(date +%s)" | timeout 2 nc $SERVER 2003 
  if [[ $? -eq 0 ]] ; then
    echo $(date '+%F %T') {"caller":"entrypoint.sh:16","pod":"$POD","level":"info","msg":"temperature $cpu_temp"}
  else
    echo $(date '+%F %T') {"caller":"entrypoint.sh:18","pod":"$POD","level":"error","msg":"cannot connect to server $SERVER"}
  fi
  # echo $cpu_temp
  sleep 60
done
