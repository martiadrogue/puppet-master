
class apache(
    $www_root = '/var/www',
  ) {

  $httpd_root = '/etc/httpd'
  $httpd_conf = "$httpd_root/conf/httpd.conf"
  $sites_available = "$httpd_root/sites-available"
  $sites_enabled = "$httpd_root/sites-enabled"

  class {'timezone': }

  package { 'httpd':
    ensure => latest,
    before => File[$httpd_conf],
  }

  file { $sites_available:
    ensure => directory,
    mode => 755,
    owner => 'root',
    group => 'root',
    require => Package['httpd'],
    before => Service['httpd'],
  }

  file { $sites_enabled:
    ensure => directory,
    mode => 755,
    owner => 'root',
    group => 'root',
    require => Package['httpd'],
    before => Service['httpd'],
  }

  file { $httpd_conf:
    ensure => present,
    mode => 644,
    owner => 'root',
    group => 'root',
    content => template("apache$httpd_conf.erb"),
  }

  service { 'httpd':
    ensure => running,
    enable => true,
    hasstatus => true,
    subscribe => [ File[$httpd_conf], Class['php'], Class['timezone'] ]
  }

}
