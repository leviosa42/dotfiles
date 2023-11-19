FROM ubuntu:latest

SHELL [ "/bin/bash", "-l", "-c" ]
RUN sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list

RUN apt update \
    && apt upgrade -y \
    && apt install -y \
        sudo \
        git \
        vim

WORKDIR /root
CMD ./.dotfiles/install.sh && /bin/bash -l