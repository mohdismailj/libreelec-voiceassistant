# libreelec-voiceassistant
```
docker run -d -p 12101:12101 --name rhasspy \
      --restart unless-stopped \
      --add-host connect.isza.tv:127.0.0.1 \
      -v "/storage/.config/rhasspy/profiles:/profiles" \
      -v "/etc/localtime:/etc/localtime:ro" \
      --device /dev/snd:/dev/snd \
      rhasspy/rhasspy \
      --user-profiles /profiles \
      --profile en      
```

