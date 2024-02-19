#!/usr/bin/env sh

mkdir -p /usr/src/app/src
# shellcheck disable=SC2164
cd /usr/src/app/src
git clone -q https://github.com/antleaf/usrn_participants.git .
gem install bundler
bundle install
bundle exec rackup
