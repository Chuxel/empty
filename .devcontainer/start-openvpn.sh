#!/usr/bin/env bash
set -e

cd "$( dirname "${BASH_SOURCE[0]}" )"
mkdir -p openvpn-tmp
cd openvpn-tmp

# Touch file to make sure this user can read it
touch openvpn.log

sudo_cmd=""
if [ "$(id -u)" != "0" ]; then
    sudo_cmd="sudo"
fi

nohup ${sudo_cmd} /bin/sh -c "openvpn --config vpnconfig.ovpn --log openvpn.log &" | tee openvpn-launch.log