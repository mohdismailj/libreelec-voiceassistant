#!/usr/bin/env bash
jsondata=`cat`

function speak()
{	
	curl -X POST -d "$1" http://iszaTV.local:12101/api/text-to-speech
}
 
intent=$(echo $jsondata | jq '.intent.name')

if [ $intent == '"KodiPlay"' ]
then 
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Stop","params":{"playerid":1},"id":1}' http://kodi:@iszaTV.local:8080/jsonrpc
	speak "Playing All Songs"	
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Open","params":{ "item":{"directory":"/storage/songs" }},"id":1}' http://kodi:@iszaTV.local:8080/jsonrpc
fi

if [ $intent == '"KodiPlayDemo"' ]
then 
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Stop","params":{"playerid":1},"id":1}' http://kodi:@iszaTV.local:8080/jsonrpc
	speak "Playing Demo Music"	
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Open","params":{ "item":{"directory":"/storage/songs/demo" }},"id":1}' http://kodi:@iszaTV.local:8080/jsonrpc
fi

if [ $intent == '"GetTime"' ]
then
	hour=$(date +"%H")
	minute=$(date +"%M")
	speak "Time now is $hour $minute"
fi

if [ $intent == '"GetHeat"' ]
then
	cpu=$((`cat /sys/class/thermal/thermal_zone0/temp`/1000))
	speak "C P U heat is $cpu degree celsius"
fi

if [ $intent == '"KodiNext"' ]
then
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Move","params":{"playerid":1,"direction":"right"},"id":1}' http://kodi:@iszaTV.local:8080/jsonrpc
fi

if [ $intent == '"KodiPrevious"' ]
then
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Move","params":{"playerid":1,"direction":"left"},"id":1}' http://kodi:@iszaTV.local:8080/jsonrpc
fi

if [ $intent == '"KodiOff"' ]
then
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Stop","params":{"playerid":1},"id":1}' http://kodi:@iszaTV.local:8080/jsonrpc
	speak "Shutting down"		
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"System.Shutdown","id":1}' http://kodi:@iszaTV.local:8080/jsonrpc
fi

if [ $intent == '"KodiRestart"' ]
then
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Stop","params":{"playerid":1},"id":1}' http://kodi:@iszaTV.local:8080/jsonrpc
	speak "Restarting"	
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"System.Reboot","id":1}' http://kodi:@iszaTV.local:8080/jsonrpc
fi

if [ $intent == '"KodiStop"' ]
then
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Stop","params":{"playerid":1},"id":1}' http://kodi:@iszaTV.local:8080/jsonrpc
	speak "Stopped Playing"
fi
