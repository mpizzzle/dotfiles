#!/bin/sh

sudo mkdir /run/postgresql/
sudo chmod 777 /run/postgresql/
pg_ctl -D ~/.local/new_db/ start
