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

file { '/srv/www/wordpress/wp_salts.sh':
    content => template('wordpress/wp_salts.sh')
  }


  exec { 'enable':
    command => '/usr/bin/sudo a2ensite wordpress',
    require => File['/etc/apache2/sites-available/wordpress.conf']
  }

  exec { 'rewrite':
    command => '/usr/bin/sudo a2enmod rewrite'
  }
 
  exec { 'disable':
    command => '/usr/bin/sudo a2dissite 000-default'
  }

    exec { 'reload':
    command => '/usr/bin/sudo service apache2 reload'
  }
    exec { 'copy-conf':
    command => '/usr/bin/sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php'
  }

    exec { 'copy-conf-db':
    command => '/usr/bin/sudo -u www-data sed -i \"s/database_name_here/wordpress/\" /srv/www/wordpress/wp-config.php'
  }
    exec { 'copy-conf-usr':
    command => '/usr/bin/sudo -u www-data sed -i \"s/username_here/wordpress/\" /srv/www/wordpress/wp-config.php'
  }
    exec { 'copy-conf-pass':
    command => '/usr/bin/sudo -u www-data sed -i \"s/password_here/wordpres123/\" /srv/www/wordpress/wp-config.php'
  }
    exec { 'permission':
    command => '/usr/bin/sudo chmod +x /srv/www/wordpress/wp_salts.sh'
  }
    exec { 'bash-script':
    command => '/usr/bin/sudo /srv/www/wordpress/wp_salts.sh'
  }
}

