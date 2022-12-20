FROM openwrtorg/rootfs:openwrt-22.03
COPY openclash/luci-app-openclash_0.45.78-beta_all.ipk /app/openclash.ipk
# RUN sed -i 's_downloads.openwrt.org_mirrors.tuna.tsinghua.edu.cn/openwrt_' /etc/opkg/distfeeds.conf
RUN mkdir /var/lock
RUN opkg update
RUN opkg remove dnsmasq
RUN opkg install coreutils-nohup \
    bash iptables dnsmasq-full \
    curl ca-certificates ipset \
    ip-full iptables-mod-tproxy \
    iptables-mod-extra libcap \
    libcap-bin ruby ruby-yaml \
    kmod-tun kmod-inet-diag \
    unzip luci luci-base \
    luci-compat luci-i18n-base-zh-cn
RUN opkg install /app/openclash.ipk
COPY clash/clash /etc/openclash/core/clash
COPY clash/clash_tun /etc/openclash/core/clash_tun
COPY clash/clash_meta /etc/openclash/core/clash_meta
RUN chmod a+x /etc/openclash/core/clash /etc/openclash/core/clash_tun /etc/openclash/core/clash_meta
EXPOSE 80
