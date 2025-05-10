#!/bin/bash

echo "Building OpenVPN client configuration..."

if [ ! -d "/etc/openvpn/server/pki/keys" ]; then
    echo "Error: Server certificates not found. Build server first."
    exit 1
fi

mkdir -p /etc/openvpn/client
cd /etc/openvpn/server/pki
source vars
./build-key --batch client1

# Create client config
cat > /etc/openvpn/client/client.ovpn <<EOF
client
dev tun
proto udp
remote <SERVER_IP> 1194
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
cipher AES-256-CBC
verb 3
<ca>
$(cat /etc/openvpn/server/pki/keys/ca.crt)
</ca>
<cert>
$(openssl x509 -in /etc/openvpn/server/pki/keys/client1.crt)
</cert>
<key>
$(cat /etc/openvpn/server/pki/keys/client1.key)
</key>
<tls-auth>
$(cat /etc/openvpn/server/pki/ta.key)
</tls-auth>
key-direction 1
EOF

echo "Client configuration created at /etc/openvpn/client/client.ovpn"
echo "Replace <SERVER_IP> with your server's public IP address"