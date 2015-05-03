#General Information

## Rackspace server `prometheus`

* Root password `YrwfhmT68A3d`
* Using public key from OneDrive

> ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1tRfi794VhvqJI6JYkheUnxdz4q1BvDNgm/l3KBPoB1EYrGop9g4gDWuAFpGKLfzwW1pEZ3fIHclMsH
> 5rS0CmzbB1snQuUnZTquep1lHjPKhgY6DJXs5Ex1DwmTt7vRKdrExZsh2lq6Zkstb5eHgo3evTMRDcs3FYKuEdH8U5v+XGlNg0OmpUkqHJaplgeJNfD+3a
> nDBvF9dUS8rW9CklQ3aHNtot6Dea7gIyHBg3/E17iqSVrMHy7Sq0DBPc9Iih5b2nbzMSu+x/EOhIFJQrHP8ZP58SkvrAmaW39rz81XZzYHE0HWTE1/64Xx
> VN2iecfKRL+ID2odQ2UNkXQ45Z rickmark@outlook.com

# Updating the server

To update the server run the script `update.sh` in `/srv/http/hot_mess` and restart the service by 
running `systemctl hot_mess-web-1`

Alternate way to reboot puma via pumactl command.