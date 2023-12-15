# Dockerfile to create the container used to send the temperature of the RPI4
# to the graphite pod
#FROM gdha/rpi-alpine-rootfs/alpine:v1.37
FROM alpine:3.19.0

LABEL org.opencontainers.image.sourcec=https://github.com/gdha/pi4-temperature2graphite
LABEL org.opencontainers.image.description "pi4-temperature2graphite build for the ARM64"
LABEL org.opencontainers.image.licenses "GPL-3.0-or-later"
LABEL maintainer "Gratien Dhaese <gratien.dhaese@gmail.com>"

COPY entrypoint.sh                                  /entrypoint.sh
COPY k3s                                            /usr/bin/kubectl
COPY api_query.sh                                   /api_query.sh

# Update and install dependencies
RUN  apk add --update nodejs npm curl
RUN  chmod a+x                                      /entrypoint.sh \
     && chmod a+x                                   /api_query.sh  \
     && echo "Europe/Brussels" >                    /etc/timezone  \
     && chmod 755 /root

ENTRYPOINT ["/entrypoint.sh"]
