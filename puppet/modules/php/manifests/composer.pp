
class php::composer (
    $target_dir = '/usr/local/bin',
    $composer_file = 'composer',
    $tmp_path = '/tmp',
  ) {

  exec { 'download_composer':
    path => '/usr/bin',
    command => "php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\"",
    cwd => $tmp_path,
    creates => "$tmp_path/composer.phar",
    logoutput => false,
    require => Package['php56w'],
  }

  exec { 'validate_composer':
    path => '/usr/bin',
    command => "php -r \"if (hash_file('SHA384', 'composer-setup.php') !== '92102166af5abdb03f49ce52a40591073a7b859a86e8ff13338cf7db58a19f7844fbc0bb79b2773bf30791e935dbd938') { unlink('composer-setup.php'); }\"",
    cwd => $tmp_path,
    logoutput => false,
    subscribe => Exec['download_composer'],
  }

  exec { 'install_composer':
    path => '/usr/bin',
    command => "sudo php $tmp_path/composer-setup.php",
    cwd => $tmp_path,
    logoutput => false,
    subscribe => Exec['validate_composer'],
  }

  exec { 'clean_instalation':
    path => '/usr/bin',
    command => "php -r \"unlink('composer-setup.php');\"",
    cwd => $tmp_path,
    logoutput => false,
    subscribe => Exec['install_composer'],
  }

  file { "$target_dir/$composer_file":
    ensure => present,
    source => "$tmp_path/composer.phar",
    group => 'root',
    mode => '0755',
    require => Exec['clean_instalation'],
  }

}
