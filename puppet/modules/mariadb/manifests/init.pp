# http://www.rackspace.com/knowledge_center/article/installing-mysql-server-on-centos

class mariadb($root_password = 'root') {

  $bin = '/usr/bin/'
  $packages = [ 'mariadb-server', 'mariadb' ]

  if ! defined(Package['mariadb']) {
    package { $packages:
      ensure => present,
    }
  }

  service { 'mariadb':
    ensure => running,
    enable => true,
    hasrestart => true,
    hasstatus => true,
    require => Package[$packages],
  }

  exec { 'root_password':
    path => $bin,
    unless => "mysqladmin -uroot -p$root_password status",
    command => "mysqladmin -uroot password '$root_password'",
    require => Service['mariadb'],
  }

  exec { 'mysql_secure_installation':
    path => $bin,
    command => "mysql -uroot -p$root_password -e \"DELETE FROM mysql.user WHERE User=''; DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1'); DROP DATABASE IF EXISTS test; FLUSH PRIVILEGES;\"",
    require => Exec['root_password'],
  }



}
