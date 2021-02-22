# libreelec-voiceassistant
```
docker run -d --name rhasspy \
      --restart unless-stopped \
      --network=host \
      -v "/storage/.config/rhasspy/profiles:/profiles" \
      -v "/etc/localtime:/etc/localtime:ro" \
      --device /dev/snd:/dev/snd \
      rhasspy/rhasspy \
      --user-profiles /profiles \
      --profile en      
```

