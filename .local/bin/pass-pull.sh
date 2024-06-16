#!/bin/sh

cd && scp root@michaelpercival.xyz:/home/m/p.gpg ./
gpg -o pass.tar.gz -d p.gpg
tar -xzf pass.tar.gz --one-top-level
rm pass.tar.gz p.gpg
