# SALTS=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
# while read -r SALT; do
# SEARCH="define('$(echo "$SALT" | cut -d "'" -f 2)"
# REPLACE=$(echo "$SALT" | cut -d "'" -f 4)
# echo "... $SEARCH ... $SEARCH ..."
# sed -i "/^$SEARCH/s/put your unique phrase here/$(echo $REPLACE | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/&/\\\&/g')/" ./wp-config.php
# done <<< "$SALTS"

find . -name wp-config.php -print | while read line
do 
    curl http://api.wordpress.org/secret-key/1.1/salt/ > wp_keys.txt
    sed -i.bak -e '/put your unique phrase here/d' -e \
    '/AUTH_KEY/d' -e '/SECURE_AUTH_KEY/d' -e '/LOGGED_IN_KEY/d' -e '/NONCE_KEY/d' -e \
    '/AUTH_SALT/d' -e '/SECURE_AUTH_SALT/d' -e '/LOGGED_IN_SALT/d' -e '/NONCE_SALT/d' $line
    cat wp_keys.txt >> $line
    rm wp_keys.txt
done