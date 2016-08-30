
class lamp(
    $vhost = $title,
    $www_root = '/var/www',
    $public = 'public',
    $root_password = '12345',
    $db_password = '12345',
  ) {
    include php
    class { 'apache': www_root => $www_root}
    apache::vhost { $vhost: public => $public }
    class { 'mariadb': root_password => $root_password }
    mariadb::db::create { 'logindb': password => $db_password }
}
