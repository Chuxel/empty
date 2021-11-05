#!/usr/bin/env bash
set -e

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y install --no-install-recommends openvpn # network-manager-openvpn pidof curl ca-certificates apt-transport-https

#architecture=$(dpkg --print-architecture)
#. /etc/os-release
#curl -fsSL https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub | gpg --dearmor > /usr/share/keyrings/openvpn-archive-keyring.gpg
#echo "deb [arch=${architecture} signed-by=/usr/share/keyrings/openvpn-archive-keyring.gpg] https://swupdate.openvpn.net/community/openvpn3/repos ${VERSION_CODENAME} main" > /etc/apt/sources.list.d/openvpn3.list
#apt-get update
#apt-get install openvpn3

cat << 'EOF' > /usr/local/share/network-manager-init.sh
#!/bin/bash
# Use sudo to run as root when required
sudoIf()
{
    if [ "$(id -u)" -ne 0 ]; then
        sudo "$@"
    else
        "$@"
    fi
}

sudoIf service network-manager start

exec "$@"
EOF
chmod +x /usr/local/share/network-manager-init.sh

# Start dbus startup script
cat << 'EOF' > /usr/local/share/dbus-init.sh
#!/bin/bash
# Use sudo to run as root when required
sudoIf()
{
    if [ "$(id -u)" -ne 0 ]; then
        sudo "$@"
    else
        "$@"
    fi
}

export DBUS_SESSION_BUS_ADDRESS="${DBUS_SESSION_BUS_ADDRESS:-"autolaunch:"}"
if [ -f "/var/run/dbus/pid" ] && ! pidof dbus-daemon  > /dev/null; then
    sudoIf rm -f /var/run/dbus/pid
fi
sudoIf /etc/init.d/dbus start 2>&1 | sudoIf tee -a /tmp/dbus-daemon-system.log > /dev/null
while ! pidof dbus-daemon > /dev/null; do
    sleep 1
done

exec "$@"
EOF
chmod +x /usr/local/share/dbus-init.sh