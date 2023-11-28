# Dockerfile to build a container image for wsl2.
# package-manager: apt-get, homebrew(linuxbrew)
FROM docker.io/library/ubuntu:jammy

USER root

ARG TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# コンテナで動かすのに特有?の設定が追加されているので消しておく
RUN rm /etc/apt/apt.conf.d/docker-*

RUN sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list && \
    apt-get -y update && \
    yes | unminimize
RUN apt-get install -y --no-install-recommends \
        # basic
        man-db man vim nano git wget curl ca-certificates build-essential sudo \
        # wslutilities/wslu
        wslu \
        # linuxbrew
        # build-essential procps curl file git ca-certificates sudo \
        # eza
        gpg \
        # bat
        bat \
        && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# eza
RUN mkdir -p /etc/apt/keyrings && \
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | gpg --dearmor -o /etc/apt/keyrings/gierens.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | tee /etc/apt/sources.list.d/gierens.list && \
    chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list && \
    apt-get update && \
    apt-get install -y eza && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# bat
RUN ln -s /usr/bin/batcat /usr/bin/bat

ARG USER_NAME=jammy
ARG USER_UID=1000
# ARG PASSWD=passwd
RUN useradd -m -s /bin/bash -u ${USER_UID} ${USER_NAME} && \
    # echo "${USER_NAME}:${PASSWD}" | chpasswd && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    { \
        echo "[user]"; \   
        echo "    default = ${USER_NAME}"; \
    } > /etc/wsl.conf

USER ${USER_NAME}
WORKDIR /home/${USER_NAME}

# Install linuxbrew
# RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
#     (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> $HOME/.bashrc && \
#     eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

RUN git clone https://github.com/leviosa42/dotfiles.git $HOME/.dotfiles && \
    cd $HOME/.dotfiles && \
    ./install.sh