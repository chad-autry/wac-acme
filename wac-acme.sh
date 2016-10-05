#!/bin/sh

# Create the account key
umask 0177
openssl genrsa -out account.key 4096
openssl genrsa -out server.key 4096
umask 0022

# Register the key with letsencrypt, e-mail comes as the first parameter
/usr/bin/letsencrypt.sh register -a account.key -e $1

# Request the certificate be signed, domain comes as the second parameter
/usr/bin/letsencrypt.sh sign -P /usr/bin/pushAcmeResponseToEtcd.sh -a account.key -k server.key -c server.pem $2

/usr/bin/etcdctl set /ssl/key $(cat ~/server.key)
/usr/bin/etcdctl set /ssl/server_pem $(cat ~/server.pem)
/usr/bin/etcdctl set /ssl/server_chain $(cat ~/server.pem_chain)
# Set a single watch value to be updated when all the certs are updated
/usr/bin/etcdctl set /ssl/watched "$(date +%s%N)"
