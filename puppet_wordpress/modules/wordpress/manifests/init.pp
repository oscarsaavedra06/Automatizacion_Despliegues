class wordpress {

  package { 'ghostscript':
    ensure => installed,
  }
  package { 'libapache2-mod-php':
    ensure => installed,
  }

 exec { 'descarga-1':
    command => '/usr/bin/sudo mkdir -p /srv/www'
  }
 exec { 'descarga-2':
    command => '/usr/bin/sudo chown www-data: /srv/www'
  }
 exec { 'descarga-3':
    command => '/usr/bin/curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www'
  }

file { '/etc/apache2/sites-available/wordpress.conf':
    content => template('wordpress/virtual-hosts.conf.erb')
  }

  exec { 'enable':
    command => '/usr/bin/sudo a2ensite wordpress',
    require => File['/etc/apache2/sites-available/wordpress.conf']
  }

  exec { 'rewrite':
    command => '/usr/bin/sudo a2enmod rewrite && sudo a2dissite 000-default && sudo service apache2 reload'
  }


    exec { 'copy-conf':
    command => '/usr/bin/sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php'
  }

    exec { 'copy-conf-db':
    command => '/usr/bin/sudo -u www-data sed -i \'s/database_name_here/wordpress/\' /srv/www/wordpress/wp-config.php'
  }
    exec { 'copy-conf-usr':
    command => '/usr/bin/sudo -u www-data sed -i \'s/username_here/wordpress/\' /srv/www/wordpress/wp-config.php'
  }
    exec { 'copy-conf-pass':
    command => '/usr/bin/sudo -u www-data sed -i \'s/password_here/wordpres123/\' /srv/www/wordpress/wp-config.php'
  }
    exec { 'wpsucli':
    command => 'sudo wget -qO wpsucli https://git.io/vykgu && sudo chmod +x ./wpsucli && sudo install ./wpsucli /usr/local/bin/wpsucli',
    path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ]
  }
    exec { 'wpsucli-exec':
    command => '/usr/bin/sudo wpsucli'
  }
  #   exec { 'install-wp-cli':
  #   command => 'sudo curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && php wp-cli.phar -info && sudo chmod +x wp-cli.phar && sudo mv wp-cli.phar /usr/local/bin/wp',
  #   path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ]
  # }
exec { 'p1':
    command => '/usr/bin/sudo curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar'
  }
  # exec { 'p2':
  #   command => '/usr/bin/sudo php wp-cli.phar'
  # }
  exec { 'p3':
    command => '/usr/bin/sudo chmod 775 wp-cli.phar'
  }

exec { 'p4':
    command => '/usr/bin/sudo mv wp-cli.phar /usr/local/bin/wp'
  }
 exec { 'create-post':
    command => '/usr/bin/sudo -u vagrant -i -- wp core install  --path=/srv/www/wordpress/ --url=http://localhost:8084 --title=Puppet_y_Wordpress --admin_user=admin12 --admin_password=abc123 --admin_email=oscarsaavedra06@gmail.com'
  }

}

