import xbmc,xbmcgui 

isPlayed=False

if xbmc.Player().isPlaying():
 xmbc.PlayerControl(Play)
 isPlayed=True


if isPlayed:
 xmbc.PlayerControl(Play)
