FROM ubuntu:18.04

MAINTAINER HaydenKow <hayden@hkowsoftware.com>

ENV TOOLCHAIN_VERSION 3a6e1a250aa385dbfd32095ec8bf0b8d9191c93d

ENV PSPDEV /pspdev
ENV PSPSDK $PSPDEV/pspsdk
ENV PATH   $PATH:$PSPDEV/bin:$PSPSDK/bin

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        g++ \
        build-essential \
        autoconf \
        cmake \
        doxygen \
        bison \
        flex \
        libncurses5-dev \
        libsdl1.2-dev \
        libreadline-dev \
        libusb-dev \
        texinfo \
        libgmp3-dev \
        libmpfr-dev \
        libelf-dev \
        libmpc-dev \
        libfreetype6-dev \
        zlib1g-dev \
        libtool \
        subversion \
        git \
        tcl \
        unzip \
        wget \
    && echo "dash dash/sh boolean false" | debconf-set-selections \
    && dpkg-reconfigure --frontend=noninteractive dash \
    && git clone https://github.com/top-sekret/psptoolchain.git /toolchain \
    && cd /toolchain \
    && git checkout -qf $TOOLCHAIN_VERSION \
    && mkdir -p /pspdev \
    && ./toolchain.sh -d /pspdev \
    && apt-get clean \
    && rm -rf \
        /pspdev/test.tmp \
        /toolchain \
        /var/lib/apt/lists/*

WORKDIR /src
CMD ["/bin/bash"]