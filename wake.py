import xbmc,xbmcgui 
import os

isPlayed=False

if xbmc.Player().isPlaying():
 xmbc.PlayerControl(Play)
 isPlayed=True

os.system("curl -X -P http://localhost/api/listen-for-command")

if isPlayed:
 xmbc.PlayerControl(Play)
