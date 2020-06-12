FROM            node:10-jessie
LABEL           maintainer=Manish email=manish@doctor24x7.in

ENV             HOME=/home/node

ENV             AGORA_RECORDINGSDKDIR=${HOME}/AgoraRecordingSdk
ENV             RECORDINGSTOREDIR=${HOME}/AgoraRecordingStore/

RUN             mkdir -p ${HOME}/www && mkdir -p ${HOME}/AgoraRecordingStore/
RUN             npm install -g sails@0.12.13 pm2
RUN             apt-get update && apt-get upgrade -y \
                  && apt-get install -y --force-yes \
                  make software-properties-common gcc \
                  imagemagick ghostscript \
                  gconf-service libasound2 libatk1.0-0 libatk-bridge2.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils \
                  wget

ENV             JAVA_HOME=/usr/src/openjdk-8-jre
RUN             mkdir -p $JAVA_HOME \
                  && curl -SL https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u212-b03/OpenJDK8U-jre_x64_linux_hotspot_8u212b03.tar.gz \
                  | tar -xzC $JAVA_HOME
ENV             PATH="${PATH}:${JAVA_HOME}/jdk8u212-b03-jre/bin/"

RUN             curl https://download.agora.io/ardsdk/release/Agora_Recording_SDK_for_Linux_v3.0.1.tar.gz | tar xz -C ${HOME} \
                  && mv $HOME/Agora_Recording_SDK_for_Linux_FULL $HOME/AgoraRecordingSdk
RUN             make -C $HOME/AgoraRecordingSdk/samples/cpp \
                  && make -C $HOME/AgoraRecordingSdk/samples/cpp install; exit 0

RUN             apt-get clean
