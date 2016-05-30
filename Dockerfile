FROM alpine:latest

RUN set -xe \
	&& apk add --update --no-progress dhcp \
	&& rm -rf /var/cache/apk/*

EXPOSE 67/udp 67/tcp

RUN ["touch", "/var/lib/dhcp/dhcpd.leases"]

VOLUME ["/etc/dhcp"]

CMD ["/usr/sbin/dhcpd", "-4", "-f", "-d", "--no-pid", "-cf", "/etc/dhcp/dhcpd.conf"]
