$document_root = '/vagrant'
$mysql_password = "abc123***"
include apache
include php
include mysql
include wordpress

exec { 'Skip Message':
  command => "echo ‘Este mensaje sólo se muestra si no se ha copiado el fichero index.html'",
  unless => "test -f ${document_root}/index.html",
  path => "/bin:/sbin:/usr/bin:/usr/sbin",
}
exec { 'php version':
  command => "echo 'php –v'",
  path => "/bin:/sbin:/usr/bin:/usr/sbin",
}

notify { 'Showing machine Facts':
  message => "Machine with ${::memory['system']['total']} of memory and $::processorcount processor/s.
              Please check access to http://$::ipaddress_enp0s8}",
}
