class apache {
  exec { 'apt-update':
    command => '/usr/bin/apt-get update'
  }
  Exec["apt-update"] -> Package <| |>

  package { 'apache2':
    ensure => installed,
  }

  service { 'apache2':
    ensure => running,
    enable => true,
    hasstatus  => true,
    restart => "/usr/sbin/apachectl configtest && /usr/sbin/service apache2 reload",
  }
}

