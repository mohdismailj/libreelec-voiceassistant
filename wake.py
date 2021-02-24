import xbmc,xbmcgui 
import os

if xbmc.Player().isPlaying():
	xbmc.executebuiltin('xbmc.PlayerControl(Play)')	

dialog = xbmcgui.Dialog()
notification = dialog.notification('iszaTV', 'Listening...')
os.system("curl -X POST http://localhost:12101/api/listen-for-command")
xbmc.executebuiltin('Dialog.Close(all,true)')
xbmc.executebuiltin('xbmc.PlayerControl(Play)')
