$document_root = '/vagrant'
$mysql_password = "abc123***"
include apache
include php
include mysql
include wordpress

notify { 'Showing machine Facts':
  message => "Machine with ${::memory['system']['total']} of memory and $::processorcount processor/s.
              Please check access to http://$::ipaddress_enp0s8}",
}
