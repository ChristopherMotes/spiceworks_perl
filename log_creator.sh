#!/usr/bin/bash
for x in user1 user2 user3
do
  COUNT=`echo $RANDOM | cut -c1`
  for i in $(seq 1 $COUNT)
  do
      while true; do
       TIME=`echo $RANDOM | cut -c1-2`
       if [ "$TIME" -lt '60' ]
         then
           break
       fi
      done
      while true; do
       DAY=`echo $RANDOM | cut -c3-4`
       if [ "$DAY" -lt '30' ]
         then
           break
       fi
      done
      while true; do
       EVENT=`echo $RANDOM | cut -c3`
       if [ "$EVENT" -lt '5' ]
         then
           break
       fi
      done

echo "2016-02-${DAY}T13:$TIME:50 $x event is numbered $EVENT" >> log.file
  done
done
