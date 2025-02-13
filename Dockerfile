#Download base image ubuntu 20.04
FROM ubuntu:20.04

# LABEL about the custom image
LABEL maintainer="evanokeeffe@gmail.com"
LABEL version="0.1"
LABEL description="Docker image for the HSI square calibration software"

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN sed -i 's/ universe/ universe multiverse/' /etc/apt/sources.list
RUN apt update &&                  \
    apt upgrade -y &&              \
    apt dist-upgrade -y &&         \
    apt install -y                 \
        git                        \
        wget                       \
        xvfb                       \
        flex                       \
        dh-make                    \
        debhelper                  \
        checkinstall               \
        fuse                       \
        bison                      \
        libxcursor-dev             \
        libxcomposite-dev          \
        software-properties-common \
        build-essential            \
        libssl-dev                 \
        libxcb1-dev                \
        libx11-dev                 \
        libgl1-mesa-dev            \
        libudev-dev                \
        qt5-default                \
        qtbase5-private-dev        \
        libqt5serialport5-dev      \
        qtmultimedia5-dev        &&\
    apt clean

WORKDIR /home/root/

RUN mkdir /home/root/src

#ADD ./* /home/root/src/

RUN cd /home/root/src && git clone https://github.com/JairoSalazarV/QtHypCam && cd QtHypCam && qmake HypCam.pro && make -j2

	
ENTRYPOINT ["/home/root/src/QtHypCam/HypCam"]
