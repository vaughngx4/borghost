#!/bin/bash
echo "Initializing"
ssh-keygen -A
mkdir -p /data/ssh/host_keys
cp /etc/ssh/ssh_host_rsa_key /data/ssh/host_keys/
cp /etc/ssh/ssh_host_dsa_key /data/ssh/host_keys/
ssh-keygen -q -t rsa -b 4096 -N '' -f /data/ssh/id_rsa <<<y >/dev/null 2>&1
echo "Setup complete, add the follow public key to the remote server to allow access:"
cat /data/ssh/id_rsa.pub
