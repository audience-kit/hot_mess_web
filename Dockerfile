FROM centos:latest

RUN yum -y update

RUN yum -y install ruby ruby-devel
RUN yum -y groupinstall "Development Tools"
RUN gem install bundler

# Here is a good checkpoint BTW

RUN yum -y install openssl-devel sqlite-devel

# Set instructions on build.
ADD Gemfile /app/
ADD Gemfile.lock /app/

WORKDIR /app
RUN bundle install --path vendor/bundle

ADD . /app

# Define working directory.
WORKDIR /app

# Set environment variables.
ENV APPSERVER puma

# Define default command.
CMD bundle exec rackup -p 8080 /app/config.ru -s $APPSERVER

# Expose ports.
EXPOSE 8080