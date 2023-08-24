#!/bin/sh

# sed -i '/xray/d' /etc/firewall.user
# sed -i '$a# xray\n/etc/init.d/xray restart' /etc/firewall.user
v=firewall.xray
# uci get "$v" >/dev/null && exit 0

uci delete "$v"

uci batch <<-EOF
	set $v=include
	set $v.type=script
	set $v.path=/usr/share/xray/firewall.include
	commit firewall
EOF

cp -a etc /
cp -a usr /

chmod 755 /usr/bin/xray /etc/init.d/xray

/etc/init.d/xray enable
# /etc/init.d/xray start

fw4 reload
