FROM python:3-alpine

ENV ANSIBLE_FORCE_COLOR="true"
ENV ANSIBLE_HOST_KEY_CHECKING="false"
ENV ANSIBLE_CONFIG="/ansible.cfg"

RUN apk add --update --no-cache \
	py-pip \
	openssh-client \
	git \
	rsync \
        libffi-dev \
        musl-dev

RUN apk add --update --no-cache \
    --virtual .build-deps \
    make \
    gcc && \
    pip install --no-cache-dir ansible && \
    apk del .build-deps

RUN mkdir ~/.ssh && \
    ssh-keyscan -t rsa gitlab.com >> ~/.ssh/known_hosts

COPY ansible.cfg entrypoint.sh /

ENTRYPOINT ["/bin/ash", "/entrypoint.sh"]
