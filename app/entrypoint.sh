#!/bin/bash

initdone="/data/ssh/id_rsa.pub"

if [ ! -e $initdone ];then
    echo "Run following command to initialize before use:"
    echo 'docker run --rm -v "/path/to/borg/data/ssh:/data/ssh" --entrypoint "/init.sh" sintelli/borghost:latest'
fi

if [ -e $initdone ]; then
    cp /data/ssh/host_keys/* /etc/ssh/
    su-exec borg mkdir -p ~/.ssh
    su-exec borg chmod 700 ~/.ssh
    su-exec borg touch ~/.ssh/authorized_keys
    su-exec borg chmod 600 ~/.ssh/authorized_keys
    cp /data/ssh/id_rsa /home/borg/.ssh/id_rsa
    cp /data/ssh/id_rsa.pub /home/borg/.ssh/id_rsa.pub
    echo "command=\"borg serve --restrict-to-path $REPO >> /dev/stdout\",restrict $SSH_AUTHORIZED_KEY" > /home/borg/.ssh/authorized_keys
    echo "❯ Starting BorgHOST with repo $REPO..."
    /usr/sbin/sshd.pam &
    echo "❯ sshd.pam started"
    bind_ip=${REMOTE_BIND_IP} || 'localhost'
    echo "❯ Starting SSH tunnel..."
    ssh -N -R "${bind_ip}":"$REMOTE_BIND_PORT":localhost:22 -p "$SSH_PORT" -o StrictHostKeyChecking=no -i /home/borg/.ssh/id_rsa "$REMOTE_USER@$REMOTE_HOST" &
    echo "❯ SSH Tunnel started"
    tail -f > /dev/null
fi
