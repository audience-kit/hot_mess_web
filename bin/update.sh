#!/bin/sh

# Begin by stopping the application
systemctl stop hot_mess.target

# Set the environment for Rails to the 'production' environment for the following commands
export RAILS_ENV=production

# Pull the latest version from git
git pull

# Install any locked dependencies via bundler
bundle install > log/bundle.log

# Precompile production assets
bundle exec rake assets:precompile

bundle exec foreman export systemd /etc/systemd/system --app hot_mess --user http

# This sets all the files to the 'http' group, they will by default have read-access
chgrp -hR http .
chmod -R g+w tmp
chmod -R g+w log

# And finally, restart the application
systemctl start hot_mess.target
