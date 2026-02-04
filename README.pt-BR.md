# Servidor DHCP em Container

Idiomas: Português (Brasil) | [English](README.md)

Um servidor DHCP simples e leve, baseado no ISC DHCP e na imagem Alpine Linux.

## Configuração DHCP

Segue um exemplo do arquivo `dhcpd.conf`. Altere-o conforme a sua necessidade. Nesse exemplo:

- a rede é 192.168.86.0,
- o roteador é 192.168.86.1,
- máscara 255.255.255.0,
- os servidores dns são 192.168.86.1 e 8.8.8.8 e por fim,
- os ips serão distribuídos aos clientes na faixa que vai do ip 192.168.86.100 até 192.168.86.250

```yml
# Arquivo dhcpd.conf

authoritative;

# "Lease time" em segundos
default-lease-time                3588;
max-lease-time                    7200;

# Subnet
subnet 192.168.86.0 netmask 255.255.255.0 {
  option routers                  192.168.86.1;
  option subnet-mask              255.255.255.0;
  option broadcast-address        192.168.86.255;
  option domain-name-servers      192.168.86.1, 8.8.8.8;
  range                           192.168.86.100 192.168.86.250;

  # Seta o dominio da rede
  option domain-name "meu-dominio.com";

  # IP's fixos fora do range de endereços acima
  host MackBook-Vendas    { hardware ethernet 70:3A:CB:D8:70:40; fixed-address 192.168.86.12; }
  host Laptop-Hospital    { hardware ethernet 44:2C:05:4B:9C:19; fixed-address 192.168.86.15; }
  host Laptop-HR          { hardware ethernet 70:3A:CB:D8:70:56; fixed-address 192.168.86.252; }
  host Cell-Seguranca     { hardware ethernet 70:3A:CB:D8:70:CF; fixed-address 192.168.86.94; }
}
```

## Como usar

1. Crie um diretório para configuração e leases, por exemplo `/opt/dhcpd`.
1. Crie `/opt/dhcpd/dhcpd.conf` com a sua configuração e crie o `/opt/dhcpd/dhcpd.leases` (pode estar vazio). Garanta permissão de escrita para o container.
1. Suba o container usando Docker Compose ou `docker run` (exemplos abaixo).
1. Se precisar, veja os logs com `docker logs -f dhcpd`.

## Como rodar o container

### Docker run

Apesar de ser preferível usar docker compose, é possível executar o container com o comando `docker run` abaixo:

```bash
docker run -d --name meu-servidor-dhcp --network host -v /opt/dhcpd:/app --restart=always lseara/dhcpd
```

### Docker Compose

Segue um exemplo de arquivo `docker-compose.yml`:

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

Certifique-se que existe o arquivo `dhcpd.leases` (pode estar vazio) e o `dhcpd.conf` do exemplo acima no diretório do volume, no caso do exemplo, `/opt/dhcpd`. O container lê `/app/dhcpd.conf` e grava `/app/dhcpd.leases`.
