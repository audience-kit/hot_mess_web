# Hot Mess

This is the Hot Mess web application and API server.

## Requirements

* Ruby Version 2.1 or higher
* Bundler
* MongoDB server
* Redis server
* Unix/POSIX like environment.  Tested with Arch Linux and Mac OS 10.10

## Vagrant

The application supports running development code inside of a Vagrant virtual machine.  The default provisioner is VirtualBox, so install it from Oracle before running vagrant.

The development fabric can be started with: `vagrant up`

The development server can be started with: `vagrant exec rails server`

## Testing

Tests are created in RSpec and exist in `spec`.  Specs can be run by issuing the command `bundle exec rake spec`

## Database

### MongoDB

MongoDB is used as the primary data storage for the application.

The database can be created with `bundle exec rake db:migrate`

### Redis

Redis is used as a backing store for background job execution.

Jobs that can be run exist in `app/jobs`

## Configuration

### Facebook API

The Facebook API connections are handled in <code>config/secrets.yml</code>

### Sound Cloud API

The SoundCloud API connections are handled in `config/secrets.yml` under `soundcloud`
