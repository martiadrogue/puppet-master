
define apache::vhost (
    $vhname = $title,
  ) {

  $www = "/var/www"
  $doc_root = "${www}/${vhname}"
  $public_html = "${doc_root}/public_html"
  $index = "${public_html}/index.html"

  $vh_conf = "${apache::sites_available}/${vhname}.conf"
  $vh_conf_link = "${apache::sites_enabled}/${vhname}.conf"

  if ! defined(File[$www]) {
    file { $www:
      ensure => directory,
      mode => 755,
      owner => 'apache',
      group => 'apache',
      before => File[$doc_root],
    }
  }

  file { $doc_root:
    ensure => directory,
    mode => 755,
    owner => 'apache',
    group => 'apache',
  }

  file { $public_html:
    ensure => directory,
    mode => 755,
    owner => 'apache',
    group => 'apache',
    require => File[$doc_root],
  }

  file { $index:
    ensure => present,
    mode => 755,
    owner => 'apache',
    group => 'apache',
    content => template("apache/var/www/public_html/index.html.erb"),
    require => File[$public_html],
  }

  file { $vh_conf:
    ensure => present,
    mode => 755,
    owner => 'root',
    group => 'root',
    content => template("apache/etc/httpd/sites-available/vhost.conf.erb"),
    require => File[$apache::sites_available],
  }

  file { $vh_conf_link:
    ensure => link,
    mode => 755,
    owner => 'root',
    group => 'root',
    target => $vh_conf,
    require => File[$vh_conf, $apache::sites_enabled],
    before => Service['httpd'],
  }

}
