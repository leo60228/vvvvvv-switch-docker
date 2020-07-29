# vi: set ft=dockerfile:
FROM devkitpro/devkita64:20200528

RUN wget https://github.com/Kitware/CMake/releases/download/v3.18.0/cmake-3.18.0-Linux-x86_64.sh \
      -q -O /tmp/cmake-install.sh \
      && chmod u+x /tmp/cmake-install.sh \
      && mkdir -p /usr/local/ \
      && /tmp/cmake-install.sh --skip-license --prefix=/usr/local/ \
      && rm /tmp/cmake-install.sh

RUN apt-get update && apt-get install -y ninja-build zip && rm -rf /var/lib/apt/lists/*
