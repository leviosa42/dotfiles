FROM docker.io/library/ubuntu:jammy

SHELL ["/bin/bash", "-c"]

USER root

ARG TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN rm /etc/apt/apt.conf.d/docker-*
RUN apt-get -y update && \
    yes | unminimize && \
    apt-get -y install sudo man-db man vim-tiny curl wget ca-certificates make && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ARG USER_NAME=jammy
ARG USER_UID=1000
ARG PASSWD=passwd

RUN useradd -m -s /bin/bash -u ${USER_UID} ${USER_NAME} && \
    echo "${USER_NAME}:${PASSWD}" | chpasswd && \
    usermod -aG sudo ${USER_NAME} && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USER_NAME}


USER ${USER_NAME}
RUN bash <(curl -sL https://raw.githubusercontent.com/leviosa42/dotfiles/main/install.sh)
