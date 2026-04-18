# DHCP Server Container

[![Docker Image Version](https://img.shields.io/docker/v/joebiellik/dhcpd?sort=semver)](https://hub.docker.com/r/joebiellik/dhcpd/tags)
[![Docker Image Size](https://img.shields.io/docker/image-size/joebiellik/dhcpd/latest)](https://hub.docker.com/r/joebiellik/dhcpd/)
[![Docker Pulls](https://img.shields.io/docker/pulls/joebiellik/dhcpd)](https://hub.docker.com/r/joebiellik/dhcpd/)
[![Docker Stars](https://img.shields.io/docker/stars/joebiellik/dhcpd)](https://hub.docker.com/r/joebiellik/dhcpd/)
[![License](https://img.shields.io/github/license/jcbiellikltd/docker-dhcpd)](https://github.com/jcbiellikltd/docker-dhcpd/blob/main/LICENSE)

[ISC DHCP server](https://www.isc.org/dhcp/) running on [Alpine Linux](https://hub.docker.com/_/alpine/).

## End-of-life notice

ISC DHCP reached [end-of-life in December 2022](https://www.isc.org/blogs/isc-dhcp-eol/). The final upstream release was **4.4.3-P1** and no further security fixes will be published by ISC.

This image is pinned to that final version on **Alpine 3.20** (the last Alpine release to ship the `dhcp` package). It is provided as-is for users with existing deployments; no further upstream patches are expected.

For new deployments, ISC recommends migrating to [Kea](https://www.isc.org/kea/).

## Tags

| Tag | Description |
| --- | --- |
| `latest`, `4.4.3-P1`, `4.4.3`, `4.4` | ISC DHCP 4.4.3-P1 on Alpine 3.20 |

## Quickstart

```yml
services:
  dhcpd:
    image: joebiellik/dhcpd
    network_mode: host
    volumes:
      - ./dhcpd.conf:/etc/dhcp/dhcpd.conf
      # Uncomment to persist leases, make sure an empty file exists first
      # - ./dhcpd.leases:/var/lib/dhcp/dhcpd.leases
```

See the [example directory](https://github.com/jcbiellikltd/docker-dhcpd/tree/main/example) for a sample `dhcpd.conf`.

## Binding to a specific interface

By default `dhcpd` listens on every interface that has a matching `subnet` declaration in the config. To restrict it to one or more specific interfaces, set the `INTERFACES` environment variable to a space-separated list of interface names:

```yml
services:
  dhcpd:
    image: joebiellik/dhcpd
    network_mode: host
    environment:
      INTERFACES: eth0
    volumes:
      - ./dhcpd.conf:/etc/dhcp/dhcpd.conf
```

Multiple interfaces:

```yml
    environment:
      INTERFACES: eth0 eth1
```

## FAQ

### Why `network_mode: host`?

DHCP is a layer-2 protocol. Clients without an IP address broadcast `DHCPDISCOVER` packets from `0.0.0.0` to `255.255.255.255` and the server needs to see both the raw broadcast and the client's original MAC address to build a valid reply.

Docker's default bridge networking sits behind NAT and a userland proxy, which:

- Does not forward link-local broadcasts (`255.255.255.255`) into the container
- Rewrites source addresses, hiding the real client MAC from the server
- Makes `subnet` clauses in `dhcpd.conf` match the wrong interface
