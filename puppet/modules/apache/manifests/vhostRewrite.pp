
define apache::vhost (
    $vhname = $title,
    $public = 'public_html',
  ) {

  $www = "/var/www"
  $doc_root = "${www}/${vhname}"
  $public_html = "${doc_root}/${public}"

  $vh_conf = "${apache::sites_available}/${vhname}.conf"
  $vh_conf_link = "${apache::sites_enabled}/${vhname}.conf"

  file { $vh_conf:
    ensure => present,
    mode => 755,
    owner => 'root',
    group => 'root',
    content => template("apache/etc/httpd/sites-available/vhost_rewrite.conf.erb"),
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
