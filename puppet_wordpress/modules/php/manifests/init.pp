class php {

  package { 'php7.2':
    ensure => installed,
    require => Package['php7.2'],
  }
  package { 'php-bcmath':
    ensure => installed,
    require => Package['php7.2'],
  }
  package { 'php-curl':
    ensure => installed,
    require => Package['php7.2'],
  }
  package { 'php-imagick':
    ensure => installed,
    require => Package['php7.2'],
  }
  package { 'php-intl':
    ensure => installed,
    require => Package['php7.2'],
  }
  package { 'php-json':
    ensure => installed,
    require => Package['php7.2'],
  }
  package { 'php-mbstring':
    ensure => installed,
    require => Package['php7.2'],
  }
  package { 'php-xml':
    ensure => installed,
    require => Package['php7.2'],
  }
  package { 'php-zip':
    ensure => installed,
    require => Package['php7.2'],
  }

  
}

