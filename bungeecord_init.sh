#!/bin/bash

#only build if jar file does not exist
echo "`date`:[INFO] Bungeecoord_init.sh"
if [ ! -f /$BUNGEECORD_HOME/BungeeCord.jar ]; then
  echo "[INFO] Downloading bungeecord jar file, be patient"
  mkdir -p /$BUNGEECORD_HOME/
  cd /$BUNGEECORD_HOME/
  wget http://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar

  #accept eola
  echo "eula=true" > /$BUNGEECORD_HOME/eula.txt

fi

# chance owner to minecraft
chown -R bungeecord.bungeecord /$BUNGEECORD_HOME/

cd /$BUNGEECORD_HOME/
echo "`date`:[INFO] Running BungeeCord server."
su - bungeecord -c 'java -Xms512M -Xmx1536M -jar BungeeCord.jar'

# fallback to root and run shell if bungeecord don't start/forced exit
# /bin/bash
