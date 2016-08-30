
if versioncmp($::puppetversion,'3.6.1') >= 0 {
  $allow_virtual_packages = hiera('allow_virtual_packages',false)
  Package {
    allow_virtual => $allow_virtual_packages,
  }
}

node /^performance\d+\.martiadrogue\.com$/ {
  include common
  include iptables
  include php
  include apache
  apache::vhost { 'provincies': public => 'public' }
  apache::vhost { 'framework.dev': public => 'public' }
  apache::vhost { 'mpwarfwk': public => 'public' }
  apache::vhost { 'performance.dev': public => 'public' }
  class { 'mariadb': root_password => '12345' }
  mariadb::db::create { 'provinciesdb': password => '12345' }
}

node /^phpunit\d+\.martiadrogue\.com$/ {
  include common
  include iptables
  include php
  include apache
  apache::vhost { 'pool': public => 'public' }
  apache::vhost { 'pool2': public => 'public' }
  class { 'mariadb': root_password => '12345' }
  mariadb::db::create { 'pooldb': password => '12345' }
}

node /^jenkins\d+\.martiadrogue\.com$/ {
  include common
  include iptables
  include php
  include apache
  apache::vhost { 'pool': public => 'public' }
  class { 'mariadb': root_password => '12345' }
  mariadb::db::create { 'pooldb': password => '12345' }
}

node /^www\d+\.martiadrogue\.com$/ {
  include common
  include iptables
  class { 'lamp':
    vhost => 'sqlbuilder',
    www_root => '/www',
    public => 'src',
    root_password => '12345',
    db_password => '12345'
  }
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
