#!/bin/sh

# As this script runs on Alpine (busybox) we cannot use bash syntax
#set -e
HOSTNAME=$(cat /etc/hostname)
#SERVER=$(/usr/local/bin/kubectl -n graphite describe pod graphite-0 | grep -i node: | cut  -d/ -f2)
SERVER=$(/usr/bin/kubectl -n graphite get pods -o wide | tail -1 | awk '{print $6}')
while true
do
  cpu_temp=$(cat /sys/class/thermal/thermal_zone0/temp)
  #cpu_temp=$(($cpu_temp/1000))
  cpu_temp=$(expr $cpu_temp / 1000)
  echo "carbon.celsius.$HOSTNAME $cpu_temp $(date +%s)" | timeout 2 nc $SERVER 2003 
  # echo $cpu_temp
  sleep 60
done
