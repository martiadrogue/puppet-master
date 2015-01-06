#
# ls /usr/share/zoneinfo
# sudo timedatectl list-timezones
#

class timezone {

  package { 'ntpdate':
    ensure => latest,
    before => Exec['synchronize_clock']
  }

  exec { 'synchronize_clock':
    path    => "/usr/sbin/",
    command => 'ntpdate 0.us.pool.ntp.org',
    before => Exec['change_hardware_clock']
  }

  exec { 'change_hardware_clock':
    path => '/usr/sbin/',
    command => 'hwclock --systohc',
  }

}
