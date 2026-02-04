FROM alpine:latest

RUN apk add --no-cache dhcp

WORKDIR /app

CMD ["/usr/sbin/dhcpd", "-4", "-f", "-d", "--no-pid", "-cf", "/app/dhcpd.conf", "-lf", "/app/dhcpd.leases"]
