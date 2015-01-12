#
# php56w-common and php56w-cli are php56w's dependencies
# php56w-common and php56w-pdo are php56w-mysql's dependencies
#

class php {

  $php_packages = [ 'php56w-mcrypt', 'php56w-mysql', 'php56w-mbstring' ]

  class { 'remi-php': }
  class { 'php::composer': }
  class { 'php::php-cs-fixer': }

  package { 'php56w':
    ensure => latest,
    require => Class["remi-php"],
  }

  package { $php_packages:
    ensure => latest,
    require => Package["php56w"],
  }

  exec { 'php_config':
    command => '/bin/sed -i "s/^;date.timezone =/date.timezone = \'Europe\/Madrid\'/g" /etc/php.ini',
    require => Package['php56w'],
  }

}
