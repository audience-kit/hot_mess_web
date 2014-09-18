systemctl stop hot_mess.target
git pull
chgrp -hR http .
systemctl start hot_mess.target