# libreelec-voiceassistant

docker run -d -p 12101:12101 \
      --name rhasspy \
      --restart unless-stopped \
      -v "/storage/.config/rhasspy/profiles:/profiles" \
      -v "/etc/localtime:/etc/localtime:ro" \
      -v "/usr/bin:/le" \
      --device /dev/snd:/dev/snd \
      rhasspy/rhasspy \
      --user-profiles /profiles \
      --profile en
      
/le/kodi-send --action="PlayerControl(Next)"

