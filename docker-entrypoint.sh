#!/bin/sh
set -e

# Ensure the lease file exists
touch /var/lib/dhcp/dhcpd.leases

# If INTERFACES is set append each interface name
if [ -n "${INTERFACES}" ]; then
	set -- "$@" ${INTERFACES}
fi

exec "$@"
