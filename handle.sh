#!/usr/bin/env bash
jsondata=`cat`
intent=$(echo $jsondata | jq '.intent.name')

if [ $intent == '"GetTime"' ]
then
	cdate = $(date +"%c")
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"GUI.ShowNotification","params":{"title":"ISZA","message":"'$date'"},"id":1}' http://kodi:@localhost:8080/jsonrpc
fi

if [ $intent == '"KodiPlay"' ]
then
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.PlayPause","params":{"playerid":1},"id":1}' http://kodi:@localhost:8080/jsonrpc
fi

if [ $intent == '"KodiNext"' ]
then
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Move","params":{"playerid":1,"direction":"right"},"id":1}' http://kodi:@localhost:8080/jsonrpc
fi

if [ $intent == '"KodiPrevious"' ]
then
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Move","params":{"playerid":1,"direction":"left"},"id":1}' http://kodi:@localhost:8080/jsonrpc
fi

if [ $intent == '"KodiMV"' ]
then
        curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Open","params":{ "item":{"directory":"/storage/Music Videos" }},"id":1}' http://kodi:@localhost:8080/jsonrpc
fi

if [ $intent == '"KodiMusic"' ]
then
        curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Open","params":{ "item":{"directory":"/storage/Music" }},"id":1}' http://kodi:@localhost:8080/jsonrpc
fi

if [ $intent == '"KodiOff"' ]
then
        curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"System.Shutdown","id":1}' http://kodi:@localhost:8080/jsonrpc
fi

if [ $intent == '"KodiRestart"' ]
then
        curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"System.Reboot","id":1}' http://kodi:@localhost:8080/jsonrpc
fi
