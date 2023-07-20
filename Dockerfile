FROM bandi13/gui-docker:local
ENTRYPOINT ["/opt/container_startup.sh"]
EXPOSE 5901
ENV VNC_PASSWD=123456

USER root

# Change Xterm font size // https://superuser.com/a/1722981/273364
RUN echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"Xterm Dark Big\" command=\"xterm -ls -bg black -fg white -fs 14 -fa DejaVuSansMono\"" \
    > /usr/share/menu/custom-docker && update-menus &&\
    echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"Xterm Light Big\" command=\"xterm -ls -fs 14 -fa DejaVuSansMono\"" \
    >> /usr/share/menu/custom-docker && update-menus

RUN mkdir -p /root

RUN apt update && apt -y install \
    docker.io bsdmainutils

COPY 1electron-deps.sh /root/
RUN bash /root/1electron-deps.sh 

COPY 2install-robomongo.sh /root/
RUN bash /root/2install-robomongo.sh

COPY 3install-openlens.sh /root/
RUN bash /root/3install-openlens.sh

COPY 4install-dbeaver.sh /root/
RUN bash /root/4install-dbeaver.sh

RUN mkdir -p /root && rm -f /root/*.sh



