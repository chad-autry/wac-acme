FROM gliderlabs/alpine:3.4
RUN apk add --update ca-certificates openssl curl
COPY wac-acme.sh /usr/bin/wac-acme.sh
RUN chmod +x /usr/bin/wac-acme.sh
RUN wget https://raw.githubusercontent.com/gheift/letsencrypt.sh/master/letsencrypt.sh
RUN mv letsencrypt.sh /usr/bin/letsencrypt.sh
RUN chmod +x /usr/bin/letsencrypt.sh
ENTRYPOINT ["/bin/sh", "/usr/bin/wac-acme.sh", "start"]
