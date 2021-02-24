import xbmc,xbmcgui 
import os
import xbmcaddon
import xbmcgui

__addon__ = xbmcaddon.Addon()
__addonname__ = __addon__.getAddonInfo('name')

line1 = "Listening..."
line2 = ""
line3 = ""

dialog = xbmcgui.Dialog().ok(__addonname__, line1, line2, line3)

isPlayed=False

if xbmc.Player().isPlaying():
	xbmc.PlayerControl(Play)
	isPlayed=True

os.system("curl -X POST http://localhost:12101/api/listen-for-command")

dialog.close()

if isPlayed:
	xbmc.PlayerControl(Play)
