#!/bin/bash

echo "Building OpenVPN server configuration..."

# Initialize PKI
cd /etc/openvpn/server
make-cadir pki
cd pki
source vars
./clean-all
./build-ca --batch
./build-key-server --batch server
./build-dh
openvpn --genkey --secret ta.key

# Create server config
cat > /etc/openvpn/server/server.conf <<EOF
port 1194
proto udp
dev tun
ca /etc/openvpn/server/pki/keys/ca.crt
cert /etc/openvpn/server/pki/keys/server.crt
key /etc/openvpn/server/pki/keys/server.key
dh /etc/openvpn/server/pki/keys/dh2048.pem
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
keepalive 10 120
tls-auth /etc/openvpn/server/pki/ta.key 0
cipher AES-256-CBC
persist-key
persist-tun
status openvpn-status.log
verb 3
EOF

echo "Server setup complete. Certificates are in /etc/openvpn/server/pki/keys/"