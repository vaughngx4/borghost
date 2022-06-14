#!/bin/bash
initdone="/data/ssh/id_rsa.pub"
while [ ! -e $initdone ];do
    echo "Run following command to initialize before use:"
    echo 'docker run --rm -v "/path/to/borg/data/ssh:/data/ssh" --entrypoint "/init.sh" sintelli/borgbase:latest'
    break;
done

while [ -e $initdone ]; do
    cp /data/ssh/host_keys/* /etc/ssh/
    su-exec borg mkdir -p ~/.ssh
    su-exec borg chmod 700 ~/.ssh
    su-exec borg touch ~/.ssh/authorized_keys
    su-exec borg chmod 600 ~/.ssh/authorized_keys
    chown borg /backups
    su-exec borg chmod 700 /backups
    cp /data/ssh/id_rsa /home/borg/.ssh/id_rsa
    cp /data/ssh/id_rsa.pub /home/borg/.ssh/id_rsa.pub
    echo "command=\"borg serve --restrict-to-path /backups/$REPO >> /dev/stdout\",restrict $SSH_AUTHORIZED_KEYS" > /home/borg/.ssh/authorized_keys
    echo "Starting BorgBase"
    /usr/sbin/sshd.pam &
    echo "Started SSH"
    bind_ip=${REMOTE_BIND_IP} || 'localhost'
    ssh -N -R ${bind_ip}:$PORT:localhost:22 -o StrictHostKeyChecking=no -i /home/borg/.ssh/id_rsa $BKP_USER@$BKP_HOST &
    tail -f > /dev/null 
    break;
done
