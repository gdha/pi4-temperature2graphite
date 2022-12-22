# Dockerfile to create the container used to send the temperature of the RPI4
# to the graphite pod
#FROM gdha/rpi-alpine-rootfs/alpine:v1.37
FROM alpine:latest

LABEL org.opencontainers.image.sourcec=https://github.com/gdha/pi4-temperature2graphite
LABEL org.opencontainers.image.description "pi4-temperature2graphite build for the ARM64"
LABEL org.opencontainers.image.licenses "GPL-3.0-or-later"
LABEL maintainer "Gratien Dhaese <gratien.dhaese@gmail.com>"

COPY entrypoint.sh                                  /entrypoint.sh

RUN  chmod a+x                                      /entrypoint.sh \
     && echo "Europe/Brussels" >                    /etc/timezone

ENTRYPOINT ["/entrypoint.sh"]
