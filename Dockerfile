FROM ruby:3.2.2
WORKDIR /usr/src/app

RUN mkdir -p /root/.ssh; \
    mkdir -p /usr/src/app/src; \
    apt-get update; \
    apt-get install -y openssh-client software-properties-common; \
    ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN git clone -q https://github.com/antleaf/usrn_participants.git /usr/src/app/src
WORKDIR /usr/src/app/src
RUN gem install bundler && bundle install

EXPOSE 4567
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]
