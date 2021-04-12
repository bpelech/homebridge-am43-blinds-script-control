#!/bin/bash
aid=2
CURRENT_POSITION_iid=9
TARGET_POSITION_iid=11
IP=192.168.0.105
PORT=51511
KEY=860-30-464
TARGET_POSITION=$1
CURRENT_POSITION=`curl -s -X GET http://$IP:$PORT/characteristics?id=$aid.$CURRENT_POSITION_iid | jq '..|.value?|select(. != null)'`
RUN_EVERY_SECONDS=10

echo "Current position: "$CURRENT_POSITION
echo "Target position: "$TARGET_POSITION


if ! [[ $TARGET_POSITION =~ ^[0-9]+$ ]] ; then
  echo "error: Target position is not a number!!!" >&2; exit 1
fi



while [ "$CURRENT_POSITION" != "$TARGET_POSITION" ]; do
# curl -s -X PUT http://192.168.0.105:51511/characteristics --data "{\"characteristics\":[{\"aid\":2,\"iid\":11,\"value\":0}]}" --header "Content-Type:Application/json" --header "authorization: 860-30-464"
  curl -s -X PUT http://$IP:$PORT/characteristics --data "{\"characteristics\":[{\"aid\":$aid,\"iid\":$TARGET_POSITION_iid,\"value\":$TARGET_POSITION}]}" --header "Content-Type:Application/json" --header "authorization: $KEY"
  echo "Calling curl to target position: "$TARGET_POSITION
  sleep $RUN_EVERY_SECONDS
  CURRENT_POSITION=`curl -s -X GET http://$IP:$PORT/characteristics?id=$aid.$CURRENT_POSITION_iid | jq '..|.value?|select(. != null)'`
  echo "Current position: "$CURRENT_POSITION
done

exit 0
