#!/bin/sh

# Create the account key
umask 0177
openssl genrsa -out account.key 4096
umask 0022

# Register the key with letsencrypt, e-mail comes as the first parameter
./letsencrypt.sh register -a account.key -e $1

# Set the thumbprint into etcd so remote web instances can respond to validation requests
./letsencrypt.sh thumbprint -a account.key | etcdctl 

# Wait 30 seconds so the nginx instances are all ready
sleep 30

# Request the certificate be signed, domain comes as the second parameter
./letsencrypt.sh sign -a account.key -k server.key -c server.pem $2
# TODO Instead of generically responding to any challenge, set both the thumbprint and the challenge response into etcd
#   And move the 30 second sleep to here

# Concatenate the certificate (public and private)


# Set the certificate into etcd for useage by the remote servers
