FROM sickp/alpine-sshd

RUN passwd -d root
RUN mkdir /transfer

COPY identity.pub /root/.ssh/authorized_keys
RUN chmod 755 /root/.ssh/authorized_keys
RUN chmod 644 /root/.ssh/authorized_keys/identity.pub
