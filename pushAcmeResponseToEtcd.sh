#!/bin/sh

# Push the response, Domain Token expected as the second param, Account THumbprint as the 3rd. (Domain as the first, but not used)
/usr/bin/etcdctl set /acme "$3.$4"

# Sleep 30 seconds so the webservers have a chance to react
sleep 30
