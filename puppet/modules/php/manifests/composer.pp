
class php::composer (
    $target_dir = '/usr/local/bin',
    $composer_file = 'composer',
    $tmp_path = '/tmp',
  ) {

  $instalation_url = 'https://getcomposer.org/composer.phar'

  exec { 'download_composer':
    path => '/usr/bin',
    command => "/usr/bin/wget --no-check-certificate ${instalation_url}",
    cwd => $tmp_path,
    creates => "$tmp_path/composer.phar",
    logoutput => false,
    require => Package['php56w'],
  }

  file { "$target_dir/$composer_file":
    ensure => present,
    source => "$tmp_path/composer.phar",
    group => 'root',
    mode => '0755',
    require => Exec['download_composer'],
  }

}
