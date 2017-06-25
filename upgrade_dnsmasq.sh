#!/bin/sh
dns=`awk 'END{print $2}' /tmp/resolv.conf.auto`

curl -L -o /root/generate_dnsmasq_chinalist.sh https://github.com/cokebar/openwrt-scripts/raw/master/generate_dnsmasq_chinalist.sh

chmod +x /root/generate_dnsmasq_chinalist.sh

curl -L -o /root/gfwlist2dnsmasq.sh https://github.com/cokebar/gfwlist2dnsmasq/raw/master/gfwlist2dnsmasq.sh

chmod +x gfwlist2dnsmasq.sh

sh /root/generate_dnsmasq_chinalist.sh -d $dns -p 53 -o /etc/dnsmasq.d/accelerated-domains.china.conf

sh /root/gfwlist2dnsmasq.sh -d 127.0.0.1 -p 5300 -o /etc/dnsmasq.d/dnsmasq_gfwlist.conf

/etc/init.d/dnsmasq restart

