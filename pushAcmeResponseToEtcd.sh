#!/bin/sh

# Push the response, Domain expected as the second param, Domain Token expected as the third param, Account Thumbprint as the fourth.
if [$1 == 'install']
    then
        /usr/bin/etcdctl set /acme/domain $2
        /usr/bin/etcdctl set /acme/token $3
        /usr/bin/etcdctl set /acme/thumbprint $4
        # I don't want to bother splitting values on the other side, so just set an independent watched value
        /usr/bin/etcdctl set /acme/watched date +%s%N

        # Sleep 30 seconds so the webservers have a chance to react
        sleep 30
fi


