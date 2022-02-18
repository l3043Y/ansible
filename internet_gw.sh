nmcli conn show
firewall-cmd --get-active-zone

nmcli connection modify eno1 connection.zone external
nmcli connection modify eno2 connection.zone internal

firewall-cmd --zone=external --add-masquerade --permanent
firewall-cmd --reload
firewall-cmd --zone=external --query-masquerade
cat /proc/sys/net/ipv4/ip_forward

# incoming packets come to 22 port of External zone are forwarded to local 1234 port
# firewall-cmd --zone=external --add-forward-port=port=22:proto=tcp:toport=1234
# firewall-cmd --list-all --zone=external

firewall-cmd --zone=internal --add-masquerade --permanent
firewall-cmd --reload

firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -o eno1 -j MASQUERADE
firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i eno2 -o eno1 -j ACCEPT
firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i eno1 -o eno2 -m state --state RELATED,ESTABLISHED -j ACCEPT