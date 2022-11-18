class mysql {
 
  package { 'mysql-server':
    ensure => installed,
  }
  package { 'php-mysql':
    ensure => installed,
    require => Package['mysql-server'],
  }

   service { 'mysql':
    ensure  => running,
    enable  => true,
    require => Package['mysql-server'],
  }

 file { "/var/lib/mysql/my.cnf":
    owner => "mysql", group => "mysql",
    source => "puppet:///modules/mysql/my.cnf",
    notify => Service["mysql"],
    require => Package["mysql-server"],
  }

 file { "/etc/my.cnf":
    require => File["/var/lib/mysql/my.cnf"],
    ensure => "/var/lib/mysql/my.cnf",
  }

exec { "set-mysql-root-pass":
    unless => "/usr/bin/mysql -u$ -p$ $",
    path => ["/bin", "/usr/bin"],
    command => "/usr/bin/sudo mysql -e \"ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$mysql_password'; FLUSH PRIVILEGES;\"",
    require => Service["mysql"],
  }

 

exec { "set-mysql-database":
    unless => "/usr/bin/mysql -u$ -p$ $",
    path => ["/bin", "/usr/bin"],
    command => "/usr/bin/mysql -uroot -p$mysql_password -e \"create database wordpress; grant all on *.* to 'wordpress'@'localhost' identified by 'wordpres123';\"",
    require => Service["mysql"],
  }

 
  

}

