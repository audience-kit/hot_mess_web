cookbook_path    ["cookbooks", "site-cookbooks"]
node_path        "nodes"
role_path        "roles"
environment_path "environments"
data_bag_path    "data_bags"
client_key       "solo.pem"
node_name        'solo'
#encrypted_data_bag_secret "data_bag_key"

knife[:berkshelf_path] = "cookbooks"
