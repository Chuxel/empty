#!/usr/bin/env bash
set -e

cd "$( dirname "${BASH_SOURCE[0]}" )"
mkdir -p openvpn-tmp
cd openvpn-tmp

if [ ! -z "${OPENVPN_CONFIG}" ]; then 
    echo "${OPENVPN_CONFIG}" > vpnconfig.ovpn
fi