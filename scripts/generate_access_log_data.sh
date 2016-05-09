#!/bin/bash

rm sampleData.dat

DT=`date`

for userId in {1..400}
do
  for i in {1..2500}
  do
    #Generate date
    ##Obtain random day within last 15 days
    x1=`shuf -i 0-14 -n 1`
    
    ##Generate a user pattern of 10 hours. Keep it consistent for userId
    userPatternFrom=$((userId%14))
    userPatternEnd=$((userPatternFrom+10))
    x12=`shuf -i $userPatternFrom-$userPatternEnd -n 1`

    ##Calculate hour difference
    x11=$(((x1*24)+x12))
    
    #NPI flag
    x2=`shuf -i 1-15 -n 1`
    npi=false
    if [ $((x2%8)) -eq 0 ]
    then
      npi=true
    fi
    
    #PII flag
    x3=`shuf -i 9-28 -n 1`
    pii=false
    if [ $((x3%15)) -eq 0 ]
    then
      pii=true
    fi
    
    #Change Password event
    x4=`shuf -i 1-50 -n 1`
    chpwd=null
    if [ $((x4%26)) -eq 0 ]
    then
      chpwd=PASSWORDRESET
      pii=false
      npi=false
    fi

    #Write data to file
    echo `date '+%Y-%m-%d %H:%M:%S' -d "$DT - $x11 hours"`","$userId","$npi","$pii","$chpwd >> sampleData.dat
    #echo `date '+%Y-%m-%d %H:%M:%S' -d "$DT - $x11 hours"`","$userId","$npi","$pii","$chpwd

  done
  echo $((userId*100/400))"% completed"
done

#Sort the event log based on the time stamp
cat sampleData.dat | sort > sampleData1.dat

