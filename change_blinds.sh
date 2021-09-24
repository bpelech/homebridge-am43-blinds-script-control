#!/bin/bash
aid=2
CURRENT_POSITION_iid=9
TARGET_POSITION_iid=11
IP=192.168.0.105
PORT=51581
TARGET_POSITION=$1
TARGET_POSITION_offset=$TARGET_POSITION
CURRENT_POSITION=`curl -s -X GET http://$IP:$PORT/characteristics?id=$aid.$CURRENT_POSITION_iid | jq '..|.value?|select(. != null)'`
RUN_EVERY_SECONDS=5
start=$SECONDS
FORCE_QUIT_AFTER_SECONDS=1800


echo "Current position: "$CURRENT_POSITION
echo "Target position: "$TARGET_POSITION

if ! [[ $TARGET_POSITION =~ ^[0-9]+$ ]] ; then
  echo "error: Target position is not a number!!!" >&2; exit 1
fi


echo "Target offset position: "$TARGET_POSITION_offset

while [ "$CURRENT_POSITION" != "$TARGET_POSITION" ]; do
  curl -s -X PUT http://$IP:$PORT/characteristics --data "{\"characteristics\":[{\"aid\":$aid,\"iid\":$TARGET_POSITION_iid,\"value\":$TARGET_POSITION_offset}]}" --hea$
  echo "Calling curl to target position: "$TARGET_POSITION
  sleep $RUN_EVERY_SECONDS
  CURRENT_POSITION=`curl -s -X GET http://$IP:$PORT/characteristics?id=$aid.$CURRENT_POSITION_iid | jq '..|.value?|select(. != null)'`
  echo "Current position: "$CURRENT_POSITION
  duration=$(( SECONDS - start ))
  if (( duration > $FORCE_QUIT_AFTER_SECONDS )) ; then
    echo "Force quit - Script is running longer than $FORCE_QUIT_AFTER_SECONDS seconds"
    exit 0
  else
    echo "Script is running: $duration seconds"
  fi
done

exit 0
