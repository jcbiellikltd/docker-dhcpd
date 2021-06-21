# DHCP Sever Container

[![Docker Pulls](https://img.shields.io/docker/pulls/joebiellik/dhcpd.svg)](https://hub.docker.com/r/joebiellik/dhcpd/)
[![Docker Stars](https://img.shields.io/docker/stars/joebiellik/dhcpd.svg)](https://hub.docker.com/r/joebiellik/dhcpd/)
[![Docker Build](https://img.shields.io/docker/cloud/automated/joebiellik/dhcpd.svg)](https://hub.docker.com/r/joebiellik/dhcpd/)
[![Docker Build Status](https://img.shields.io/docker/cloud/build/joebiellik/dhcpd.svg)](https://hub.docker.com/r/joebiellik/dhcpd/)

[ISC DHCP server](https://www.isc.org/downloads/dhcp/) running on [Alpine Linux](https://hub.docker.com/_/alpine/).

## Configuration

See [example directory](https://github.com/jcbiellikltd/docker-dhcpd/tree/master/example) for sample config file.

## Quickstart

```yml
dhcpd:
  image: joebiellik/dhcpd

  net: host

  volumes:
    # Config pass through
    - ./dhcpd.conf:/etc/dhcp/dhcpd.conf
```
