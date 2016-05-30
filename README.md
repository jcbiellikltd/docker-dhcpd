# DHCPd
[![Docker Pulls](https://img.shields.io/docker/pulls/joebiellik/dhcpd.svg)](https://hub.docker.com/r/joebiellik/dhcpd/)

[ISC DHCP server](https://www.isc.org/software/dhcp/) server running on [Alpine Linux](https://hub.docker.com/_/alpine/).

## Configuration
See [example directory](https://github.com/jcbiellikltd/docker-dhcpd/tree/master/example) for sample config file.

## Quickstart
```
dhcpd:
  image: joebiellik/bind

  net: host

  volumes:
    # Config pass through
    - ./dhcpd.conf:/etc/dhcp/dhcpd.conf
```
