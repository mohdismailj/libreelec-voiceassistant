import xbmc,xbmcgui 
import os
def is_playback_paused():
    return bool(xbmc.getCondVisibility("Player.Paused"))
if not is_playback_paused():
        xbmc.Player().pause()		
dialog = xbmcgui.Dialog()
notification = dialog.notification('iszaTV', 'Listening...')
os.system("curl -X POST http://localhost:12101/api/listen-for-command")
xbmc.executebuiltin('Dialog.Close(all,true)')
xbmc.executebuiltin('xbmc.PlayerControl(Play)')
if is_playback_paused():
        xbmc.Player().pause()
