name 'app'
description 'This role includes the actual application running and handling web requests'
run_list 'recipe[ruby_build]'