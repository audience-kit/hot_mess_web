name 'worker'
description 'This role runs background tasks for the application'
run_list 'recipe[ruby_build]', 'recipe[redis]'