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

  exec { 'ntpd_stop':
    path    => "/sbin/",
    command => 'service ntpd stop',
    require => Package['ntp'],
    before  => Exec['synchronize_clock'],
  }

  exec { 'synchronize_clock':
    path    => "/sbin/",
    command => 'ntpdate 1.es.pool.ntp.org', # 2.europe.pool.ntp.org 3.europe.pool.ntp.org
    before => Exec['change_hardware_clock'],
  }

  exec { 'change_hardware_clock':
    path => '/sbin/',
    command => 'hwclock --systohc',
  }

  service { 'ntpd_start':
    name => 'ntpd',
    ensure => running,
    enable => true,
    hasrestart => true,
    hasstatus => true,
    subscribe  => Exec['change_hardware_clock'],
  }

}
