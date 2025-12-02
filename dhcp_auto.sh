#!/bin/bash

#Exit if there wan an error.
set -e

#Now if we modify the dhcp configuration file (sudo nano /etc/dhcp/dhcpd.conf).
interface=$(ip route | grep default | awk '{print $5}')
cidr=$(ip -o -f inet addr show "$interface" | awk '{print $4}')
subnet=$(ipcalc -n "$cidr" | awk '/Network/ {print $2}' | cut -d/ -f1)
netmask=$(ipcalc -m "$cidr" | awk '/Netmask/ {print $2}')
echo "Between which range wanna have the IP's (start):"
read range1
echo "And the end of the range:"
read range2
dns="8.8.8.8"
gateway=$(ip route | grep default | awk '{print $3}')
broadcast=$(ip -o -f inet addr show "$interface" | awk '{for(i=1;i<=NF;i++) if($i=="brd") print $(i+1)}')


cat <<EOF > /etc/dhcp/dhcpd.conf
subnet $subnet netmask $netmask {
  range $range1 $range2;
  option routers $gateway;
  option broadcast-address $broadcast;
  option domain-name-servers $dns;
  default-lease-time 691200;
  max-lease-time 691200;
}
EOF

#Edit the DHCP server configuration file to specify the network interface (sudo nano /etc/default/isc-dhcp-server).
cat <<EOF > /etc/default/isc-dhcp-server
INTERFACESv4="$interface"
INTERFACESv6=""
EOF

#To check that the configuration has no errors.
dhcpd -t -cf /etc/dhcp/dhcpd.conf

#To apply the changes done.
systemctl restart isc-dhcp-server.service

#Enable the DHCP.
systemctl enable isc-dhcp-server

#Start the service.
systemctl start isc-dhcp-server

#Check the status.
systemctl status isc-dhcp-server

#To give permisions to dhcp to pass without problem the firewall.
ufw allow 67/udp || true

#Apply the changes.
ufw reload || true


