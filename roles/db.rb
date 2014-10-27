name 'db'
description 'This role stores persistant data for the application'
run_list 'recipe[mongodb]'
default_attributes "mongodb" => { "config" => { "pidfilepath" => '/var/run/mongodb/mongodb.pid' } }