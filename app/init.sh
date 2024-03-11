#!/bin/bash
echo "❯ Initializing..."
echo "❯ Generating host keys..."
ssh-keygen -A
mkdir -p /data/ssh/host_keys
cp /etc/ssh/ssh_host_rsa_key /data/ssh/host_keys/
cp /etc/ssh/ssh_host_dsa_key /data/ssh/host_keys/
echo "❯ Generating SSH key pair..."
ssh-keygen -q -t rsa -b 4096 -N '' -f /data/ssh/id_rsa <<<y >/dev/null 2>&1
echo "❯ WARNING!"
echo "❯ WARNING!"
echo ""
echo "Please note that "GatewayPorts yes" should be set on the remote host in /etc/ssh/sshd_config"
echo ""
echo "❯ WARNING!"
echo "❯ WARNING!"
echo "❯ Setup complete, add the following public key to the remote server to allow access:"
cat /data/ssh/id_rsa.pub
