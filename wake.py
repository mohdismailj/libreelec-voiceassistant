import xbmc,xbmcgui 
import os

dialog = xbmcgui.Dialog()
notification = dialog.notification('Kodi', 'Listening...')

isPlayed=False

if xbmc.Player().isPlaying():
	xbmc.executebuiltin('xbmc.PlayerControl(Play)')	
	isPlayed=True

os.system("curl -X POST http://localhost:12101/api/listen-for-command")
xbmc.executebuiltin('Dialog.Close(all,true)')

if isPlayed:
	xbmc.executebuiltin('xbmc.PlayerControl(Play)')
