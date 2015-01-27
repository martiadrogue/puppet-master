#
# php56w-common and php56w-cli are php56w's dependencies
# php56w-common and php56w-pdo are php56w-mysql's dependencies
# libxslt is php56w-xml dependencies
#

class php {

  $php_packages = [ 'php56w-mcrypt', 'php56w-mysql', 'php56w-mbstring', 'php56w-xml' ]

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

  file { '/etc/php.ini':
    owner => 'root',
    group => 'root',
    mode => '0440',
    source => "puppet://$::server/modules/php/etc/php-development.ini",
    require => Package['php56w', $php_packages],
  }

}
