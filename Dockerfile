#FROM ubuntu:latest
#
#RUN mkdir -p /root/app /root/.ssh; \
#    apt-get update; \
#    apt-get install -y openssh-client git software-properties-common; \
#    ssh-keyscan github.com >> /root/.ssh/known_hosts

FROM ruby:3.2.2
WORKDIR /usr/src/app

RUN mkdir -p /root/.ssh; \
    apt-get update; \
    apt-get install -y openssh-client software-properties-common; \
    ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN git clone -q https://github.com/antleaf/SComCaT.git /usr/src/app

RUN #gem install bundler && bundle install