#!/bin/sh

# seconds in 30 days
seconds=`expr 86400 \\* 30`

# Make sure no othe renewal job is running concurrentlly
/usr/bin/etcdctl mk /acme/lock lock --ttl 180
if [ $? -ne 0 ]
then
    # just exit, another instance is running
    exit 0
fi

# Check the expiration/existence of the cert
if openssl x509 -checkend $seconds -noout -in /var/ssl/fullchain.pem
then
  echo "Certificate is still good for at least another 30 days!"
  exit 0
fi

# Create the account key
umask 0177
openssl genrsa -out account.key 4096
openssl genrsa -out server.key 4096
umask 0022

# Get the email and domain name from etcd
email=$(/usr/bin/etcdctl get /domain/email)
domain=$(/usr/bin/etcdctl get /domain/name)

# Register the key with letsencrypt
/usr/bin/letsencrypt.sh register -a account.key -e $email

# Request the certificate be signed
/usr/bin/letsencrypt.sh sign -P /usr/bin/pushAcmeResponseToEtcd.sh -a account.key -k server.key -c server.pem $domain

# Check the expiration/existence of the cert
if ! openssl x509 -checkend $seconds -noout -in server.pem_chain
then
  echo "Did not succesfully sign the certificate!"
  exit 0
fi

# -- Means there are no more command options, needed since the cert files start with '-'
/usr/bin/etcdctl set -- /ssl/key "$(cat server.key)"
/usr/bin/etcdctl set -- /ssl/server_pem "$(cat server.pem)"
/usr/bin/etcdctl set -- /ssl/server_chain "$(cat server.pem_chain)"
# Set a single watch value to be updated when all the certs are updated
/usr/bin/etcdctl set /ssl/watched "$(date +%s%N)"
