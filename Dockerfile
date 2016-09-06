FROM gliderlabs/alpine:3.4
RUN apk add --update ca-certificates openssl && \
    apk del --purge openssl
COPY wac-acme.sh /usr/bin/wac-acme.sh
RUN chmod +x /usr/bin/wac-acme.sh
ENTRYPOINT ["/bin/sh", "/usr/bin/wac-acme.sh", "start"]
