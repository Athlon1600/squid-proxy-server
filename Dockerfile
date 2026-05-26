FROM debian:stable-slim

LABEL maintainer="Athlon1600"

# Default shell
CMD ["/bin/bash"]

RUN apt-get update && \
    apt-get install -y squid squidclient apache2-utils dos2unix nano vim && \
    rm -rf /var/lib/apt/lists/*

# Copy custom Squid configuration
COPY etc/squid.conf /etc/squid/squid.conf
COPY acl/blocked_ips.txt /etc/squid/acl/blocked_ips.txt
COPY acl/blocked_domains.txt /etc/squid/acl/blocked_domains.txt

# Copy entrypoint script and make it executable
COPY entrypoint.sh /usr/local/bin/start-squid
RUN chmod +x /usr/local/bin/start-squid

# Expose the Squid proxy port
EXPOSE 3128/tcp

ENTRYPOINT ["start-squid"]
