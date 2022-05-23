FROM debian:buster-slim
#
ARG PUID=1000
#
ENV DEBIAN_FRONTEND=noninteractive
ENV USER steam
ENV HOME_DIR "/home/${USER}"
ENV STEAM_DIR "${HOME_DIR}/steamcmd"
ENV STEAM_APP_ID 4940
ENV STEAM_APP ns2
ENV STEAM_APP_DIR "${HOME_DIR}/${STEAM_APP}-server"
#
COPY requirements.txt /tmp
COPY setup/ /opt/setup/scripts/
#
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get -y --no-install-recommends install apt-utils \
    && apt-get -y dist-upgrade \
    && apt-get -y --no-install-recommends install \
    libc6-dev \
    lib32gcc1 \
    lib32stdc++6 \
    lib32z1 \
    libsdl2-2.0-0 \
    libsdl2-2.0-0:i386 \
    locales \
    curl \
    wget \
    git \
    python3-pip \
    build-essential \
    python3-dev \
    unzip \
    zip \
    libcurl4 \
    ca-certificates \
    python3-minimal \
    python3-pkg-resources \
    screen \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
    && apt-get clean \
    && mkdir -p /opt/setup/scripts \
    && useradd -u "${PUID}" -m "${USER}" \
    && su "${USER}" \
    && set -x \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && su "${USER}" -c \
    "mkdir -p \"${STEAM_DIR}\" \
    && wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar xvzf - -C \"${STEAM_DIR}\" \
    && \"./${STEAM_DIR}/steamcmd.sh\" +quit \
    && mkdir -p \"${HOME_DIR}/.steam/sdk32\" \
    && ln -s \"${STEAM_DIR}/linux32/steamclient.so\" \"${HOME_DIR}/.steam/sdk32/steamclient.so\" \
    && ln -s \"${STEAM_DIR}/linux32/steamcmd\" \"${STEAM_DIR}/linux32/steam\" \
    && ln -s \"${STEAM_DIR}/steamcmd.sh\" \"${STEAM_DIR}/steam.sh\"" \
    && ln -s "${STEAM_DIR}/linux32/steamclient.so" "/usr/lib/i386-linux-gnu/steamclient.so" \
    && ln -s "${STEAM_DIR}/linux64/steamclient.so" "/usr/lib/x86_64-linux-gnu/steamclient.so" \
    && mkdir -p "${STEAM_APP_DIR}" \
    && chown -R "${USER}:${USER}" "/opt/setup/scripts/" "${STEAM_APP_DIR}" \	
    && chmod 755 -R /usr/local/bin/ \
    && chmod 755 /tmp/requirements.txt \
    && pip3 install -r /tmp/requirements.txt \
    && rm /tmp/requirements.txt \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* 
#
USER ${USER}
#
VOLUME ${STEAM_APP_DIR}
#
WORKDIR ${HOME_DIR}
#
CMD python3 /opt/setup/scripts/bootstrap.py
#
EXPOSE 27015-27016/tcp
EXPOSE 27015-27016/udp
EXPOSE 80/tcp