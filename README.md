# DHCP Server Container

Languages: English | [Português (Brasil)](README.pt-BR.md)

Simple and lightweight DHCP server based on ISC DHCP and the Alpine Linux image.

## DHCP Configuration

Below is an example of a `dhcpd.conf` file. Adjust it as needed. In this example:

- the network is 192.168.86.0,
- the router is 192.168.86.1,
- netmask is 255.255.255.0,
- DNS servers are 192.168.86.1 and 8.8.8.8, and
- IPs are distributed in the range from 192.168.86.100 to 192.168.86.250

```yml
# dhcpd.conf file

authoritative;

# Lease time in seconds
default-lease-time                3588;
max-lease-time                    7200;

# Subnet
subnet 192.168.86.0 netmask 255.255.255.0 {
  option routers                  192.168.86.1;
  option subnet-mask              255.255.255.0;
  option broadcast-address        192.168.86.255;
  option domain-name-servers      192.168.86.1, 8.8.8.8;
  range                           192.168.86.100 192.168.86.250;

  # Set the network domain
  option domain-name "my-domain.com";

  # Static IPs outside the range above
  host MacBook-Sales      { hardware ethernet 70:3A:CB:D8:70:40; fixed-address 192.168.86.12; }
  host Laptop-Hospital    { hardware ethernet 44:2C:05:4B:9C:19; fixed-address 192.168.86.15; }
  host Laptop-HR          { hardware ethernet 70:3A:CB:D8:70:56; fixed-address 192.168.86.252; }
  host Cell-Security      { hardware ethernet 70:3A:CB:D8:70:CF; fixed-address 192.168.86.94; }
}
```

## How to use

1. Create a directory for config and leases, for example `/opt/dhcpd`.
1. Create `/opt/dhcpd/dhcpd.conf` with your configuration and create `/opt/dhcpd/dhcpd.leases` (it may be empty). Make sure the container can write to it.
1. Start the container using Docker Compose or `docker run` (examples below).
1. If needed, check logs with `docker logs -f dhcpd`.

## Running the container

### Docker run

Although Docker Compose is preferred, you can run the container with `docker run`:

```bash
docker run -d --name my-dhcp-server --network host -v /opt/dhcpd:/app --restart=always lseara/dhcpd
```

### Docker Compose

Example `docker-compose.yml`:

```yml
services:

  dhcpd:
    image: lseara/dhcpd
    network_mode: host
    container_name: dhcpd
    restart: unless-stopped
    environment:
      TZ: 'America/Sao_Paulo'
    volumes:
      - /opt/dhcpd:/app
```

Make sure the volume directory (in this example `/opt/dhcpd`) contains the `dhcpd.conf` from the example above and a `dhcpd.leases` file (it may be empty). The container reads `/app/dhcpd.conf` and writes `/app/dhcpd.leases`.
