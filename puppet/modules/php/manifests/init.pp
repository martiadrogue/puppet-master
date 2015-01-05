#
# php56w-common and php56w-cli are php56w's dependences
#

class php {

  $php_packages = [ 'php56w-mcrypt', 'php56w-pdo' ]

  class { 'remi-php': }
  class { 'php::composer': }

  package { 'php56w':
    ensure => latest,
    require => Class["remi-php"],
  }

  package { $php_packages:
    ensure => latest,
    require => Package["php56w"],
  }

  exec { 'php_config':
    command => '/bin/sed -i "s/^;date.timezone =/date.timezone = \'Europe\/Vienna\'/g" /etc/php.ini',
    require => Package['php56w'],
  }

}
