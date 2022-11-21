FROM ubuntu:jammy

LABEL maintainer="dmitry@kernelgen.org"

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get update && \
    apt-get -y --no-install-recommends install \
        i3status \
        i3-wm \
        git \
        net-tools \
        python3 \
        rxvt-unicode \
        supervisor \
        fonts-dejavu \
        x11vnc \
        xvfb \
        xserver-xorg \
        xinit \
        ca-certificates && \
    apt-get clean

# noVNC setup
WORKDIR /usr/share/
RUN git clone https://github.com/kanaka/noVNC.git
RUN ln -s /usr/share/noVNC/vnc_lite.html /usr/share/noVNC/index.html
WORKDIR /usr/share/noVNC/utils/
RUN git clone https://github.com/kanaka/websockify

RUN export DISPLAY=:0.0

COPY supervisord.conf /etc/

EXPOSE 8083

RUN useradd -m user
WORKDIR /home/user

CMD ["/usr/bin/supervisord"]

