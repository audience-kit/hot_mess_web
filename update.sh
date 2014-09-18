#!/bin/sh

export RAILS_ENV=production

git pull
chgrp -hR http .
bundle install
bundle exec rake assets:precompile
systemctl restart hot_mess.target