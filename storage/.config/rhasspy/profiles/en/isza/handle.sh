#!/usr/bin/env bash
jsondata=`cat`

#echo $jsondata  >> /profiles/en/isza/handle.log

#echo -e "\nEND\n\n"  >> /profiles/en/isza/handle.log

function speak()
{
	echo $jsondata | jq --arg v "$1" '. + {"speech": { "text" : $v }}'	
}
 
intent=$(echo $jsondata | jq '.intent.name')

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
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Move","params":{"playerid":1,"direction":"right"},"id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
fi

if [ $intent == '"KodiPrevious"' ]
then
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Move","params":{"playerid":1,"direction":"left"},"id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
fi

if [ $intent == '"KodiMV"' ]
then
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Stop","params":{"playerid":1},"id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
	speak "Playing Music Video"
	sleep 5
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Open","params":{ "item":{"directory":"/storage/Music Videos" }},"id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
fi

if [ $intent == '"KodiMusic"' ]
then 
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Stop","params":{"playerid":1},"id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
	speak "Playing Music"
	sleep 5
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Open","params":{ "item":{"directory":"/storage/Music" }},"id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
fi

if [ $intent == '"KodiOff"' ]
then
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Stop","params":{"playerid":1},"id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
	speak "Shutting down"
	sleep 5
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"System.Shutdown","id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
fi

if [ $intent == '"KodiRestart"' ]
then
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Stop","params":{"playerid":1},"id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
	speak "Restarting"
	sleep 5
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"System.Reboot","id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
fi

if [ $intent == '"KodiStop"' ]
then
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Stop","params":{"playerid":1},"id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
	speak "Stopped Playing"
fi
