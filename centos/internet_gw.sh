nmcli conn show
firewall-cmd --get-active-zone

nmcli connection modify eno1 connection.zone external
nmcli connection modify eno2 connection.zone internal

sudo nmcli connection modify ext_net_E748 connection.zone external
sudo nmcli connection modify int_net_E74A connection.zone internal
firewall-cmd --zone=external --add-masquerade --permanent
firewall-cmd --reload
firewall-cmd --zone=external --query-masquerade
cat /proc/sys/net/ipv4/ip_forward

# incoming packets come to 22 port of External zone are forwarded to local 1234 port
# firewall-cmd --zone=external --add-forward-port=port=22:proto=tcp:toport=1234
# firewall-cmd --list-all --zone=external
# firewall-cmd --add-forward-port=port=port-number:proto=tcp|udp:toport=port-number:toaddr=IP

# firewall-cmd --add-forward-port=port=8022:proto=tcp:toport=22:toaddr=192.168.1.80
# firewall-cmd --permanent --add-forward-port=port=8022:proto=tcp:toaddr=192.168.1.80:toport=22

firewall-cmd --zone=internal --add-masquerade --permanent
firewall-cmd --reload

firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -o eno1 -j MASQUERADE
firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i eno2 -o eno1 -j ACCEPT
firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i eno1 -o eno2 -m state --state RELATED,ESTABLISHED -j ACCEPT


minio server http://host{1...4}/export{1...16} http://host{5...12}/export{1...16}

n, err := s3Client.PutObject(
    "my-bucketname", 
    "my-objectname", 
    object, 
    objectStat.Size(),
    minio.PutObjectOptions{
        ContentType: "application/octet-stream", 
        StorageClass: "REDUCED_REDUNDANCY"
        }
    )

export MINIO_STORAGE_CLASS_STANDARD=EC:3
export MINIO_STORAGE_CLASS_RRS=EC:2