name 'web'
description 'This role handles front end web traffic and proxies to the app role'
run_list 'recipe[nginx]'

default_attributes :nginx => 
  {
    :pid                => "/run/nginx.pid",
    :worker_connections => "1024"
  }