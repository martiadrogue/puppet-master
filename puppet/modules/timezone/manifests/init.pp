# timedatectl
# ls /usr/share/zoneinfo
# sudo timedatectl list-timezones
#

class timezone {

  package { 'ntp':
    ensure => latest,
  }

  exec { 'rm_timezone':
    path => '/bin/',
    command => 'rm /etc/localtime',
  }

  file {'/etc/localtime':
    ensure => link,
    mode => 755,
    owner => 'root',
    group => 'root',
    target => '/usr/share/zoneinfo/Europe/Madrid',
    subscribe => Exec['rm_timezone']
  }
}
