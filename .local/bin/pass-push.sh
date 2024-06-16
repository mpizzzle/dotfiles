#!/bin/sh

cd && tar -czf p.tar.gz -C $PASSWORD_STORE_DIR .
gpg -o p.gpg -r mpxyz -e p.tar.gz
scp ./p.gpg root@michaelpercival.xyz:/home/m
rm p.tar.gz p.gpg
