include_recipe 'hot_mess::default'

user 'hot_mess' do
  system true
  shell '/bin/false'
  
  action :create
end

service 'hot_mess.target' do
  action [ :enable, :start ]
end