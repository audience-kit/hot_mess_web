# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure('2') do |config|
  config.vm.box      = 'parallels/ubuntu-14.04'
  config.vm.hostname = 'hotmess-dev'

  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]

    chef.add_recipe "apt"
    chef.add_recipe "nodejs"
    chef.add_recipe "ruby_build"
    chef.add_recipe "rbenv::user"
    chef.add_recipe "rbenv::vagrant"
    chef.add_recipe "vim"
    chef.add_recipe "mysql::server"
    chef.add_recipe "mysql::client"
    chef.add_recipe "mongodb::default"

    # Install Ruby 2.2.1 and Bundler
    # Set an empty root password for MySQL to make things simple
    chef.json = {
        rbenv: {
            user_installs: [{
                                user: 'vagrant',
                                rubies: ["2.2.1"],
                                global: "2.2.1",
                                gems: {
                                    "2.2.1" => [
                                        { name: "bundler" }
                                    ]
                                }
                            }]
        },
        mysql: {
            server_root_password: ''
        }
    }
  end
end