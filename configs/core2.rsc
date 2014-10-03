# jan/02/1970 00:01:08 by RouterOS 6.20
# software id = SQDP-66V4
#
/interface bridge
add name=bridge-gateway
add admin-mac=D4:CA:6D:A2:63:AE auto-mac=no mtu=1500 name=bridge-local
/interface ethernet
set [ find default-name=ether1 ] name=ether1-gateway
set [ find default-name=ether2 ] name=ether2-gateway
set [ find default-name=ether4 ] comment=SERVER1
set [ find default-name=ether5 ] comment=SERVER2
set [ find default-name=ether6 ] name=ether6-master-local
set [ find default-name=ether7 ] master-port=ether6-master-local name=\
    ether7-slave-local
set [ find default-name=ether8 ] master-port=ether6-master-local name=\
    ether8-slave-local
set [ find default-name=ether9 ] master-port=ether6-master-local name=\
    ether9-slave-local
set [ find default-name=ether10 ] master-port=ether6-master-local name=\
    ether10-slave-local
/ip neighbor discovery
set ether1-gateway discover=no
set ether4 comment=SERVER1
set ether5 comment=SERVER2
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa2-psk mode=dynamic-keys name=roadshow \
    supplicant-identity=MikroTik wpa-pre-shared-key=IPv6-Roadshow \
    wpa2-pre-shared-key=IPv6-Roadshow
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n disabled=no frequency=2437 \
    ht-rxchains=0 ht-txchains=0 l2mtu=2290 mode=ap-bridge security-profile=\
    roadshow ssid=IPv6-Roadshow
/ip ipsec proposal
set [ find default=yes ] enc-algorithms=3des
/ip pool
add name=default-dhcp ranges=192.168.88.10-192.168.88.254
/ip dhcp-server
add address-pool=default-dhcp disabled=no interface=bridge-local lease-time=\
    3d name=default
/system logging action
set 1 disk-file-name=log
set 2 remember=yes
set 3 src-address=0.0.0.0
/interface bridge nat
add chain=srcnat
/interface bridge port
add bridge=bridge-local interface=ether3
add bridge=bridge-local interface=ether4
add bridge=bridge-local interface=ether5
add bridge=bridge-local interface=ether6-master-local
add bridge=bridge-local interface=sfp1
add bridge=bridge-local interface=wlan1
add bridge=bridge-gateway interface=ether1-gateway
add bridge=bridge-gateway interface=ether2-gateway
/ip address
add address=192.168.88.1/24 comment="default configuration" interface=\
    bridge-local network=192.168.88.0
/ip dhcp-client
add dhcp-options=hostname,clientid disabled=no interface=bridge-gateway
/ip dhcp-server lease
add address=192.168.88.11 comment=Server1 mac-address=68:5B:35:CF:1D:03
add address=192.168.88.12 comment=Server2 mac-address=68:5B:35:CF:1B:7D
/ip dhcp-server network
add address=192.168.88.0/24 comment="default configuration" dns-server=\
    192.168.88.1 gateway=192.168.88.1
/ip dns
set allow-remote-requests=yes
/ip dns static
add address=192.168.88.1 name=router
/ip firewall filter
add chain=input comment="default configuration" protocol=icmp
add chain=input comment="default configuration" connection-state=established
add chain=input comment="default configuration" connection-state=related
# in/out-interface matcher not possible when interface (ether1-gateway) is slave - use master instead (bridge-gateway)
add action=drop chain=input comment="default configuration" in-interface=\
    ether1-gateway
add chain=forward comment="default configuration" connection-state=\
    established
add chain=forward comment="default configuration" connection-state=related
add action=drop chain=forward comment="default configuration" \
    connection-state=invalid
/ip firewall nat
add action=masquerade chain=srcnat comment="default configuration" disabled=\
    yes out-interface=ether2-gateway to-addresses=0.0.0.0
/ip proxy
set cache-path=web-proxy1
/ip service
set telnet disabled=yes
set api disabled=yes
set winbox disabled=yes
set api-ssl disabled=yes
/ip upnp
set allow-disable-external-interface=no
/snmp
set trap-community=public
/system identity
set name=core2
/tool mac-server
set [ find default=yes ] disabled=yes
add interface=ether2-gateway
add interface=ether3
add interface=ether4
add interface=ether5
add interface=ether6-master-local
add interface=ether7-slave-local
add interface=ether8-slave-local
add interface=ether9-slave-local
add interface=sfp1
add interface=wlan1
add interface=bridge-local
/tool mac-server mac-winbox
set [ find default=yes ] disabled=yes
add interface=ether2-gateway
add interface=ether3
add interface=ether4
add interface=ether5
add interface=ether6-master-local
add interface=ether7-slave-local
add interface=ether8-slave-local
add interface=ether9-slave-local
add interface=sfp1
add interface=wlan1
add interface=bridge-local
