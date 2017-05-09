###
[![Build Status](https://travis-ci.org/chad-autry/wac-acme.svg?branch=master)](https://travis-ci.org/chad-autry/wac-acme)
[![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg)](https://registry.hub.docker.com/u/chadautry/wac-acme/)
# wac-acme
Wrapped ACME client for integration with the [wac](https://github.com/chad-autry/wac-bp) stack

* Packaged as a docker image
* Requires host networking to access etcd
* Requires e-mail and domain passed in etcd
* Only allows one instance to run at a time
* Creates a certificate, if current cert expires within 30 days
    * Expects cert at /var/ssl/fullchain.pem
* Distributes the http challenege response through etcd
    * Waits 30 seconds for endpoints to host the challenge response
* Notifies CA to complete validation
* Creates and issues CSR with now authorized account key
* Distributes signed certificate to the cluster over etcd

## Example
```
sudo etcdctl set /domain/email <email>
sudo etcdctl set /domain/name <domain>
sudo docker run --net host -v /var/ssl:/var/ssl --name acme chadautry/wac-acme
```

## Note 
This acme 'client' doesn't directlly host the response, or have cron job helpers.
