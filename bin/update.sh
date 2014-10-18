#!/bin/sh

systemctl restart hot_mess.target
# Set the environment for Rails to the 'production' environment for the following commands
export RAILS_ENV=production

# Pull the latest version from git
git pull

# Install any locked dependencies via bundler
bundle install > log/bundle.log

# Precompile production assets
bundle exec rake assets:precompile

# This sets all the files to the 'http' group, they will by default have read-access
chgrp -hR http .
chmod -R g+w tmp
chmod -R g+w log

# And finally, restart the web hosting service
systemctl start hot_mess.target