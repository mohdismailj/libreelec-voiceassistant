# Control Kodi with Voice on LibreELEC using Rhasspy

Install Docker Add-ons in KODI
```
SYSTEM > Add-ons > Install from repository > LibreELEC Add-ons > Services > Docker
```

Installing Rhasspy
```
docker pull rhasspy/rhasspy
```

Starting Rhasspy
```
docker run -d -p 12101:12101 --name rhasspy \
      --restart unless-stopped \
      -v "/storage/.config/rhasspy/profiles:/profiles" \
      -v "/etc/localtime:/etc/localtime:ro" \
      --device /dev/snd:/dev/snd \
      rhasspy/rhasspy \
      --user-profiles /profiles \
      --profile en
```

Configure & Testing

[VIDEO Demonstration](https://youtu.be/T64JQegdtRc)



