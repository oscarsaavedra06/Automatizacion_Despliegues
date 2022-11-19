cd /opt
sudo curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
sudo chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/
cd /srv/www/wordpress
wp core install --url=http://localhost:8084 --title=Puppet y wordpress --admin_user=admin12 --admin_password=abc123 --admin_email=oscarsaavedra06@gmail.com