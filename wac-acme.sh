#!/bin/sh

# Create the account key
umask 0177
openssl genrsa -out account.key 4096
umask 0022

# Register the key with letsencrypt, e-mail comes as the first parameter
/usr/bin/letsencrypt.sh register -a account.key -e $1

# Request the certificate be signed, domain comes as the second parameter
/usr/bin/letsencrypt.sh sign -P /usr/bin/etcdAcmeResponse.sh -a account.key -k server.key -c server.pem $2

# Concatenate the certificate (public and private)


# Set the certificate into etcd for useage by the remote servers
