# Forward DNS requests from remote WireGuard clients to the default
# gateway on the internal bridged network that the WireGuard container
# is attached to. The gateway routes queries out from the bridged network to
# the host's network. This results in queries being sent to any daemon or
# container that is listening on host port 53 (eg PiHole, AdGuardHome, dnsmasq
# or bind9).
#
# Acknowledgement: @ukkopahis

GW=$(ip route list default | head -1 | cut -d " " -f 3)
echo Creating Corefile to use DNS at $GW
echo "# Generated by use-container-dns.sh
. {
    loop
    forward . dns://${GW}
}" > /config/coredns/Corefile

