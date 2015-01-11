# http://www.rackspace.com/knowledge_center/article/installing-mysql-server-on-centos

class mysql($root_password = 'root') {

  $bin = '/usr/bin/'

  class { 'remi-mysql': }

  if ! defined(Package['mysql-community-server']) {
    package { 'mysql-community-server':
      ensure => present,
      require => Class['remi-mysql'],
    }
  }

  file { '/etc/my.cnf':
    owner => 'root',
    group => 'root',
    mode => '644'
    source => 'puppet:///modules/mysql/etc/my.cnf',
    notify => Service['mysqld'],
    require => Package['mysql-community-server'],
  }

  service { 'mysqld':
    ensure => running,
    enable => true,
    hasrestart => true,
    hasstatus => true,
  }

  exec { 'root_password':
    path => $bin,
    unless => "mysqladmin -uroot -p$root_password status",
    command => "mysqladmin -uroot password '$root_password'",
    require => Service['mysqld'],
  }

  exec { 'mysql_secure_installation':
    path => $bin,
    command => "mysql -uroot -p$root_password -e \"DELETE FROM mysql.user WHERE User=''; DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1'); DROP DATABASE IF EXISTS test; FLUSH PRIVILEGES;\"",
    require => Exec['root_password'],
  }



}
