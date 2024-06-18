from ubuntu:jammy

# 
# docker build . -t pellcorp/buildroot
# docker login
# docker push pellcorp/buildroot
#

ADD 2204-sources.list /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y python3 build-essential sudo wget git curl cpio unzip rsync bc libncurses-dev patchelf file

RUN adduser --disabled-password --gecos "" developer && \
  usermod -a -G sudo developer && \
  echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/nopasswd

USER developer
WORKDIR /home/developer
