name 'worker'
description 'This role runs background tasks for the application'
run_list 'recipe[redis]', 'recipe[hot_mess]'