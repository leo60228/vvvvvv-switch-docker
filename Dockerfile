# vi: set ft=dockerfile:
FROM devkitpro/devkita64:20190720

RUN dkp-pacman -Syyu --noconfirm

RUN wget https://github.com/Kitware/CMake/releases/download/v3.16.4/cmake-3.16.4-Linux-x86_64.sh \
      -q -O /tmp/cmake-install.sh \
      && chmod u+x /tmp/cmake-install.sh \
      && mkdir -p /usr/local/ \
      && /tmp/cmake-install.sh --skip-license --prefix=/usr/local/ \
      && rm /tmp/cmake-install.sh

RUN wget -qO- https://github.com/vbe0201/switch-cmake/archive/c5b5441d956e23d801089260a84199bc6def82b3.tar.gz | \
    tar --transform 's/^switch-cmake-c5b5441d956e23d801089260a84199bc6def82b3/switch-cmake/' \
        -xzv -C /usr/local/share/

RUN apt-get update && apt-get install -y ninja-build zip && rm -rf /var/lib/apt/lists/*

ENV VVVVVV_CE_SWITCH_BUILD=1

