
define apache::vhost (
    $vhname = $title,
    $tipe = 'rewrite',
    $public = 'public_html',
  ) {

  $www_root = $apache::www_root
  $public_global = "${www_root}/html"
  $doc_root = "${www_root}/${vhname}"
  $public_html = "${doc_root}/${public}"
  $index = "${public_html}/index.html"
  $logs = [ "${doc_root}/error.log", "${doc_root}/requests.log" ]

  $vh_conf = "${apache::sites_available}/${vhname}.conf"
  $vh_conf_link = "${apache::sites_enabled}/${vhname}.conf"

  if ! defined(File[$www_root]) {
    file { $www_root:
      ensure => directory,
      mode => 755,
      owner => 'root',
      group => 'root',
      before => File[$doc_root],
    }

    file { $public_global:
      ensure => directory,
      mode => 755,
      owner => 'root',
      group => 'root',
      subscribe => File[$www_root],
    }
  }

  file { $doc_root:
    ensure => directory,
    mode => 755,
    owner => 'vagrant',
    group => 'vagrant',
  }

  file { $logs:
    ensure => present,
    mode => 777,
    owner => 'root',
    group => 'root',
    content => '',
    require => File[$doc_root],
  }

  file { $public_html:
    ensure => directory,
    mode => 755,
    owner => 'vagrant',
    group => 'vagrant',
    require => File[$doc_root],
  }

  file { $index:
    ensure => present,
    mode => 755,
    owner => 'vagrant',
    group => 'vagrant',
    content => template("apache/var/www/public_html/index.html.erb"),
    require => File[$public_html],
  }

  file { $vh_conf:
    ensure => present,
    mode => 755,
    owner => 'root',
    group => 'root',
    content => template("apache/etc/httpd/sites-available/vhost_$tipe.conf.erb"),
    require => File[$apache::sites_available],
  }

  file { $vh_conf_link:
    ensure => link,
    mode => 755,
    owner => 'root',
    group => 'root',
    target => $vh_conf,
    require => File[$vh_conf, $logs, $apache::sites_enabled],
    before => Service['httpd'],
  }

}
