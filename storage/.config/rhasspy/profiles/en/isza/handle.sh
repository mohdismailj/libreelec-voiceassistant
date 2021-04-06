#!/usr/bin/env bash
jsondata=`cat`

function speak()
{
	curl -X POST -d "$1" http://192.168.1.100:12101/api/text-to-speech
}

function playerid()
{
	playerid=$( curl -s -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.GetActivePlayers","id":1}' http://kodi:@192.168.1.100:8080/jsonrpc | jq '.result[0] .playerid')
	echo $playerid 
}

function kodistop()
{

 if [ $(playerid) != "null" ]; 
then 

	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Stop","params":{"playerid":'"$(playerid)"'},"id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
	sleep 3

fi

}

intent=$(echo $jsondata | jq '.intent.name')


if [ $intent == '"GetTime"' ]
then
	hour=$(date +"%H")
	minute=$(date +"%M")
	speak "Time now is $hour $minute"
fi

if [ $intent == '"GetName"' ]
then
	speak "My name is Mycroft"
fi

if [ $intent == '"GetHeat"' ]
then
	cpu=$((`cat /sys/class/thermal/thermal_zone0/temp`/1000))
	speak "C P U heat is $cpu degree celsius"
fi

if [ $intent == '"KodiNext"' ]
then
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Move","params":{"playerid":'"$(playerid)"',"direction":"right"},"id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
fi

if [ $intent == '"KodiPrevious"' ]
then
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Move","params":{"playerid":'"$(playerid)"',"direction":"left"},"id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
fi

if [ $intent == '"KodiPlayBEST"' ]
then 
	kodistop
	speak "Playing Favourite Songs"	
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"Player.Open","params":{ "item":{"directory":"/storage/songs/best" }},"id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
fi

if [ $intent == '"KodiOff"' ]
then
	kodistop
	speak "Shutting down"		
       sleep 5
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"System.Shutdown","id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
fi

if [ $intent == '"KodiRestart"' ]
then
	kodistop
	speak "Restarting"	
	curl -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"System.Reboot","id":1}' http://kodi:@192.168.1.100:8080/jsonrpc
fi

if [ $intent == '"KodiStop"' ]
then
	kodistop
	speak "Stopped Playing"
fi
