FROM gliderlabs/alpine:3.4
RUN apk add --update ca-certificates openssl curl vim
COPY wac-acme.sh /usr/bin/wac-acme.sh
RUN chmod +x /usr/bin/wac-acme.sh
COPY pushAcmeResponseToEtcd.sh /usr/bin/pushAcmeResponseToEtcd.sh
RUN chmod +x /usr/bin/pushAcmeResponseToEtcd.sh
RUN wget https://raw.githubusercontent.com/chad-autry/letsencrypt.sh/v0.0.2/letsencrypt.sh
RUN mv letsencrypt.sh /usr/bin/letsencrypt.sh
RUN chmod +x /usr/bin/letsencrypt.sh
RUN curl -L https://github.com/coreos/etcd/releases/download/v2.3.7/etcd-v2.3.7-linux-amd64.tar.gz -o etcd-v2.3.7-linux-amd64.tar.gz
RUN tar xzvf etcd-v2.3.7-linux-amd64.tar.gz
RUN mv etcd-v2.3.7-linux-amd64/etcdctl /usr/bin/etcdctl
RUN rm -r etcd-v2.3.7-linux-amd64
RUN rm etcd-v2.3.7-linux-amd64.tar.gz
ENTRYPOINT ["/bin/sh", "/usr/bin/wac-acme.sh"]
