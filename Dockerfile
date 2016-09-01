FROM gliderlabs/alpine:3.4
RUN apk add --update ca-certificates openssl tar && \
    wget https://github.com/coreos/etcd/releases/download/v2.3.7/etcd-v2.3.7-linux-amd64.tar.gz && \
    tar xzvf etcd-v2.3.7-linux-amd64.tar.gz && \
    mv etcd-v2.3.7-linux-amd64/etcdctl /usr/bin/etcdctl && \
    apk del --purge tar openssl && \
    rm -Rf etcd-v2.3.7-linux-amd64* /var/cache/apk/*
COPY wac-acme.sh /usr/bin/wac-acme.sh
RUN chmod +x /usr/bin/wac-acme.sh
ENTRYPOINT ["/bin/sh", "/usr/bin/wac-acme.sh", "start"]