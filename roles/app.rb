name 'app'
description 'This role includes the actual application running and handling web requests'
run_list 'recipe[rvm::user_install]','recipe[hot_mess]'

override_attributes 'rvm' => { 'default_ruby' => 'ruby-2.1' }