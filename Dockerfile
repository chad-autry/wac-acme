FROM gliderlabs/alpine:3.4
RUN apk add --update ca-certificates openssl && \
    apk del --purge openssl
COPY wac-acme.sh /usr/bin/wac-acme.sh
RUN chmod +x /usr/bin/wac-acme.sh
COPY letsencrypt.sh /usr/bin/letsencrypt.sh
RUN chmod +x /usr/bin/letsencrypt.sh
ENTRYPOINT ["/bin/sh", "/usr/bin/wac-acme.sh", "start"]
