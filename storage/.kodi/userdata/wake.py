import xbmc,xbmcgui 
import os
def is_playback_paused():
    return bool(xbmc.getCondVisibility("Player.Paused"))
if not is_playback_paused():
        xbmc.Player().pause()		
dialog = xbmcgui.Dialog()
notification = dialog.notification('iszaTV', 'Listening...',xbmcgui.NOTIFICATION_INFO,5000,True)
os.system("curl -X POST http://localhost:12101/api/listen-for-command")
xbmc.executebuiltin('Dialog.Close(all,true)')
if is_playback_paused():
        xbmc.Player().pause()
