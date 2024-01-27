FROM docker.io/alpine:3.17.2

ENV ANSIBLE_FORCE_COLOR="true"
ENV ANSIBLE_HOST_KEY_CHECKING="false"
ENV ANSIBLE_CONFIG="/ansible.cfg"

COPY ansible.cfg entrypoint.sh /

RUN apk add --no-cache \
	openssh-client \
	git \
	ansible

RUN apk add --no-cache --virtual .build-deps \
    make \
    gcc && \
    pip install --no-cache-dir ansible && \
    apk del .build-deps

RUN mkdir ~/.ssh && \
    ssh-keyscan -t rsa gitlab.com >> ~/.ssh/known_hosts

ENTRYPOINT ["/bin/ash", "/entrypoint.sh"]
