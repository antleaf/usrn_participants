#FROM ubuntu:latest
#
#RUN mkdir -p /root/app /root/.ssh; \
#    apt-get update; \
#    apt-get install -y openssh-client git software-properties-common; \
#    ssh-keyscan github.com >> /root/.ssh/known_hosts

FROM ruby:3.2.2
WORKDIR /usr/src/app

RUN mkdir -p /root/.ssh; \
    mkdir -p /usr/src/app/src; \
    apt-get update; \
    apt-get install -y openssh-client software-properties-common; \
    ssh-keyscan github.com >> /root/.ssh/known_hosts

#COPY ./cmd.sh ./cmd.sh

RUN git clone -q https://github.com/antleaf/usrn_participants.git /usr/src/app/src
WORKDIR /usr/src/app/src
RUN gem install bundler && bundle install

EXPOSE 9292
ENTRYPOINT ["bash"]
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "9292"]

#CMD bundle exec rackup