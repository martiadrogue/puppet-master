
class php::phpmetrics (
    $target_dir = '/usr/local/bin',
    $phpmetrics_file = 'phpmetrics',
    $tmp_path = '/tmp',
  ) {

  $full_tmp_path = "$tmp_path/$phpmetrics_file"
  $full_path = "$target_dir/$phpmetrics_file"

  exec { 'download_phpmetrics':
    path => '/usr/bin',
    command => "wget https://github.com/Halleck45/PhpMetrics/raw/master/build/$phpmetrics_file.phar -O $phpmetrics_file",
    cwd => $tmp_path,
    creates => $full_tmp_path,
    logoutput => false,
    require => Package['php56w'],
  }

  file { $full_path:
    ensure => present,
    source => $full_tmp_path,
    group => 'root',
    mode => '0755',
    require => Exec['download_phpmetrics'],
  }

}
