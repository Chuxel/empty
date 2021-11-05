#!/usr/bin/env bash
set -e
script_folder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${script_folder}"
cp -f "vpnconfig.ovpn.base" "vpnconfig.ovpn"
sed -i '/\$CLIENTCERTIFICATE/ {s/\$CLIENTCERTIFICATE//; r client.crt
}' vpnconfig.ovpn
sed -i '/\$PRIVATEKEY/ {s/\$PRIVATEKEY//; r client.key
}' vpnconfig.ovpn

(nohup openvpn --config vpnconfig.ovpn &) > /tmp/openvpn-launch.log