class php {

  package { 'php7.2':
    ensure => installed
  }
  package { 'php-bcmath':
    ensure => installed
  }
  package { 'php-curl':
    ensure => installed
  }
  package { 'php-imagick':
    ensure => installed
  }
  package { 'php-intl':
    ensure => installed,
  }
  package { 'php-json':
    ensure => installed,
  }
  package { 'php-mbstring':
    ensure => installed,
  }
  package { 'php-xml':
    ensure => installed,
  }
  package { 'php-zip':
    ensure => installed,
  }

  
}

