class apache {
                  
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


  file { '/etc/apache2/sites-enabled/000-default.conf':
    ensure => absent,
    require => Package['apache2'],
  }

  file { '/etc/apache2/sites-available/vagrant.conf':
    content => template('apache/virtual-hosts.conf.erb'),
    require => File['/etc/apache2/sites-enabled/000-default.conf'],
  }

  file { "/etc/apache2/sites-enabled/vagrant.conf":
    ensure  => link,
    target  => "/etc/apache2/sites-available/vagrant.conf",
    require => File['/etc/apache2/sites-available/vagrant.conf'],
    notify  => Service['apache2'],
  }

  file { "${document_root}/index.html":
    ensure  => present,
    source => 'puppet:///modules/apache/index.html',
    require => File['/etc/apache2/sites-enabled/vagrant.conf'],
    notify  => Service['apache2'],
  }

  service { 'apache2':
    ensure => running,
    enable => true,
    hasstatus  => true,
    restart => "/usr/sbin/apachectl configtest && /usr/sbin/service apache2 reload",
  }
}

