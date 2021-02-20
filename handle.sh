#!/usr/bin/env bash
jsondata=`cat`
intent=$(echo $jsondata | jq '.intent.name')
#echo $intent  >> /profiles/en/isza/handle.log
if [ $intent == '"GetTime"' ]
then
	cdate = $(date +"%c")
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"GUI.ShowNotification","params":{"title":"ISZA","message":"'$date'"},"id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
fi

if [ $intent == '"KodiPlay"' ]
then
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.PlayPause","params":{"playerid":1},"id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
fi

if [ $intent == '"KodiNext"' ]
then
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Move","params":{"playerid":1,"direction":"right"},"id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
fi

if [ $intent == '"KodiPrevious"' ]
then
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Move","params":{"playerid":1,"direction":"left"},"id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
fi
