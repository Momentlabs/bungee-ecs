FROM 033441544097.dkr.ecr.us-east-1.amazonaws.com/minecraft-ecs

MAINTAINER David Rivas david@momentlabs.io

ENV BUNGEECORD_HOME=/bungeecord

RUN useradd -s /bin/bash -d /${BUNGEECORD_HOME} -m bungeecord

# TODO: Update the script to look pull the latest bungee cord down.
# Or update the makefile to at least go get the latet OR BOTH.
RUN if [ ! -d ${BUNGEECORD_HOME} ]; then mkdir ${BUNGEECORD_HOME}/plugins;  fi
ADD BungeeCord.jar ${BUNGEECORD_HOME}/BungeeCord.jar

# Plugins.
ADD plugins/BungeeServerManager.jar ${BUNGEECORD_HOME}/plugins/BugeeServerManager.jar

# Configuration
ADD config.yml ${BUNGEECORD_HOME}/config.yml
ADD bungeecord_init.sh ${BUNGEECORD_HOME}/bungeecord_init.sh

# EULA
RUN echo "eual=true" >${BUNGEECORD_HOME}/eula.txt

# This is the default connection.
EXPOSE 25577

WORKDIR $BUNGEECORD_HOME
ENTRYPOINT ./bungeecord_init.sh
# ENTRYPOINT java -Xms512M -Xmx1536m -XX:MAxPermSize=128M -jar ./BungeeCord.jar
# ENTRYPOINT /bin/bash