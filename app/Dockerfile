FROM library/alpine:3.15
LABEL maintainer="vaughngx4 (vaughng@pm.me)"
RUN adduser -S -h /home/borg -s /bin/sh -D borg
ENV HOME /home/borg
ENV APP_TMP_DATA=/tmp
RUN apk update && apk add --no-cache --upgrade \
    bash \
    su-exec \
    openssh-server-pam \
    openssh-server \
    openssh-client \
    python3 \
    borgbackup && ln -sf python3 /usr/bin/python
RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key
RUN bash -c 'set +o history'
COPY ./entrypoint.sh /docker-entrypoint.sh
COPY ./init.sh /init.sh
COPY ./sshd_config /etc/ssh/sshd_config
ENTRYPOINT ["/docker-entrypoint.sh"]
