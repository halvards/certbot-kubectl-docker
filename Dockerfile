FROM certbot/certbot

RUN pip install certbot-dns-cloudflare && \
    wget -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(wget -qO- https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x /usr/local/bin/kubectl

COPY letsencrypt.sh /opt/letsencrypt.sh

ENTRYPOINT ["/opt/letsencrypt.sh"]
