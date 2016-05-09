#!/bin/bash

rm poc1_hourly_event.dat

dt=`date`
for i in {359..0}
do
  for userId in {1..400}
  do
    echo `date '+%Y-%m-%d_%H' -d "$dt - $i hours"`","$userId",8,8" >> poc1_hourly_event.dat
  done
  echo $((100-($i*10/36)))"% completed"
done
