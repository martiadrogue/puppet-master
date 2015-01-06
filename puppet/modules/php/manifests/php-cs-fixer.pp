
class php::php-cs-fixer (
    $target_dir = '/usr/local/bin',
    $php_cs_fixer_file = 'php-cs-fixer',
    $tmp_path = '/tmp',
  ) {

  exec { 'download_php_cs_fixer':
    path => '/usr/bin',
    command => 'curl -s http://get.sensiolabs.org/php-cs-fixer.phar -o php-cs-fixer',
    cwd => $tmp_path,
    creates => "$tmp_path/$php_cs_fixer_file",
    logoutput => false,
    require => Package['php56w'],
  }

  file { "$target_dir/$php_cs_fixer_file":
    ensure => present,
    source => "$tmp_path/$php_cs_fixer_file",
    group => 'root',
    mode => '0755',
    require => Exec['download_php_cs_fixer'],
  }

}
