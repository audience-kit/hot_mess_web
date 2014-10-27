#
# Cookbook Name:: hot_mess
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'rvm'
include_recipe 'rvm::system'

rvm_ruby '2.1'

package 'sqlite-devel'

rvm_shell 'bundle' do
  ruby_string '2.1'
  cwd '/vagrant'
  code "bundle install"
end

rvm_shell 'db:migrate' do
  ruby_string '2.1'
  cwd '/vagrant'
  code 'bundle exec rake db:migrate'
end

rvm_shell 'assets:precompile' do
  ruby_string '2.1'
  cwd '/vagrant'
  code 'bundle exec rake assets:precompile'
end

rvm_shell 'foreman export' do
  ruby_string '2.1'
  cwd '/vagrant'
  code 'bundle exec foreman export systemd /etc/systemd/system --app hot_mess --user hot_mess'
end

