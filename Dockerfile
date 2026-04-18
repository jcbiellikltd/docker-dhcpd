FROM alpine:3.20

LABEL org.opencontainers.image.title="dhcpd" \
      org.opencontainers.image.version="4.4.3-P1" \
      org.opencontainers.image.description="ISC DHCP server running on Alpine Linux" \
      org.opencontainers.image.authors="Joe Biellik" \
      org.opencontainers.image.vendor="J C Biellik Ltd" \
      org.opencontainers.image.licenses="MPL-2.0" \
      org.opencontainers.image.url="https://hub.docker.com/r/joebiellik/dhcpd" \
      org.opencontainers.image.source="https://github.com/jcbiellikltd/docker-dhcpd" \
      org.opencontainers.image.documentation="https://github.com/jcbiellikltd/docker-dhcpd/blob/main/README.md" \
      org.opencontainers.image.base.name="docker.io/library/alpine:3.20"

RUN apk add --no-cache dhcp

EXPOSE 67/udp

VOLUME ["/etc/dhcp"]

COPY --chmod=755 docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["/usr/sbin/dhcpd", "-4", "-f", "-d", "--no-pid"]
