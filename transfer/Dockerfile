FROM sickp/alpine-sshd:7.5

RUN passwd -d root
COPY identity.pub /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

RUN mkdir /transfer
