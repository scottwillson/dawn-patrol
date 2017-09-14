FROM sickp/alpine-sshd

RUN passwd -d root
RUN mkdir /transfer

COPY identity.pub /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys
