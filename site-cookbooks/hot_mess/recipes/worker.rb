include_recipe 'hot_mess::default'

user 'hot_mess_worker' do
  system true
  shell '/bin/false'
  
  action :create
end
