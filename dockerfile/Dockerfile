FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8

RUN apt-get update \
 && apt-get -qq -y install \
        build-essential \
        chrpath \
        cpio \
        diffstat \
        gawk \
        gcc-multilib \
        git-core \
        libncurses5-dev \
        locales \
        python \
        python3 \
        python3-distutils \
        repo \
        socat \
        sudo \
        texinfo \
        tmux \
        unzip \
        wget \
 && sed --in-place '/en_US.UTF-8/s/^# //' /etc/locale.gen \
 && locale-gen \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* \
 && rm -rf /var/tmp/*

ARG GID
ARG HOME
ARG UID
ARG USER

RUN addgroup --system --gid ${GID} ${USER} \
 && adduser --system --uid ${UID} --gid ${GID} --home ${HOME} ${USER} --shell /bin/bash \
 && echo "${USER} ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
