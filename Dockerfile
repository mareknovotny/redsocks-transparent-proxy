FROM ubuntu

MAINTAINER <mnovotny@redhat.com>

RUN apt-get update && apt-get -y install iptables redsocks

RUN echo 'base{log_debug = on; log_info = on; log = "file:/tmp/reddi.log"; \
       daemon = on; redirector = iptables;} \
       redsocks { local_ip = 0.0.0.0; local_port = 31338; ip = 0.0.0.0; \
       port = 31337; type = socks5; }' > /etc/redsocks.conf

COPY ./iptables-with-redsocks.sh /root/iptables-with-redsocks.sh

CMD ["service", "restart", "redsocks"] 

#ENTRYPOINT ["sh", "/root/iptables-with-redsocks.sh"]
