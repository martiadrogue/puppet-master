
if versioncmp($::puppetversion,'3.6.1') >= 0 {
  $allow_virtual_packages = hiera('allow_virtual_packages',false)
  Package {
    allow_virtual => $allow_virtual_packages,
  }
}

node /^www\d+\.martiadrogue\.com$/ {
  include common
  include iptables
  include php
  include apache
  apache::vhost { 'alpha.dev': }
  apache::vhost { 'beta.dev': }
  apache::vhost { 'omega.dev': }
  class { 'mysql': root_password => '12345' }
  mysql::db::create { 'blogdb': password => '12345' }
}

node /^db\d+\.martiadrogue\.com$/ {
  include common
  class { 'iptables': config => 'sql' }
  class { 'mysql': root_password => '12345' }
  mysql::db::create { 'devdb': password => '12345' }
}

node default {
  include twilight-zone
}
