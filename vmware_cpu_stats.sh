#!/bin/bash

#Sleep duration is in seconds
sleepDuration=1

oldContention=0
oldCpuUsed=0

while true;
do
  # Grab all of the stats for this run
  allStats="$(vmware-toolbox-cmd stat raw text resources)"

  # Get the CPU stats and calculate the change over the period
  newContention=`echo "$allStats" | grep vm.cpu.contention.cpu | awk '{print $3}'`
  newCpuUsed=`echo "$allStats" | grep vm.cpu.used | awk '{print $3}'`

  usedChange=$(($newCpuUsed - $oldCpuUsed))
  contentionChange=$(($newContention - $oldContention))

  totalChange=$(($usedChange + $contentionChange))

  contentionPercent=`awk "BEGIN {print ($contentionChange*100)/$totalChange}"`
  usedPercent=`awk "BEGIN {print ($usedChange*100)/$totalChange}"`

  # This is the output line
  echo "vm.cpu.contention.cpu `date` contention: $contentionPercent used: $usedPercent"

  # Store the current values for the next iteration
  oldContention=$newContention
  oldCpuUsed=$newCpuUsed

  # Sleep so the CPU can do something
  sleep $sleepDuration
done
