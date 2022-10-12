FROM ubuntu:20.04
RUN apt-get update
RUN apt-get install sudo
ARG DEBIAN_FRONTEND=noninteractive

ENV TZ="America/Los_Angeles"\
    DEBIAN_FRONTEND=noninteractive

# remove any old versions
RUN apt-get remove docker docker.io containerd runc

# install packages to allow apt to use a repository over HTTPS:
RUN apt-get install -y \
    sudo \
    curl \
    ca-certificates \
    gnupg \
    lsb-release

# add Docker's Official GPG key
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# set up repository# set up repository# set up repository
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null 

RUN sudo chmod a+r /etc/apt/keyrings/docker.gpg

# install latest version of Docker Engine
RUN apt-get update
RUN apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

