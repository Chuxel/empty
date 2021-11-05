#!/usr/bin/env bash
set -e
cd "$( dirname "${BASH_SOURCE[0]}" )"
(nohup openvpn --config vpnconfig.ovpn &) > /tmp/openvpn-launch.log