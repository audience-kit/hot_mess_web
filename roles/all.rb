name 'all'
description 'This role includes all other roles in the application for single box environments'
run_list 'role[db]', 'role[web]', 'role[app]', 'role[worker]'