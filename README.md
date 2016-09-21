###
[![Build Status](https://travis-ci.org/chad-autry/wac-acme.svg?branch=master)](https://travis-ci.org/chad-autry/wac-acme)
[![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg)](https://registry.hub.docker.com/u/chadautry/wac-acme/)
# wac-acme
Certificate renewal and distribution for the [wac](https://github.com/chad-autry/wac-bp) stack

* Packaged as a docker image
* Creates a certificate
* Distributes the http challenege response through etcd
    * Waits 30 seconds for endpoints to host the challenge response
* Notifies CA to complete validation
* Creates and issues CSR with now authorized 
* Distributes signed certificate to the cluster over etcd

Note: This acme 'client' doesn't directlly host the response, or have cron job helpers. It will also just blindy renew the certificate without checking if it is required.
