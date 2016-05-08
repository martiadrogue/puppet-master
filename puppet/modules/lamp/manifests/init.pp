
class lamp(
    $vhost = 'vhost',
    $public = 'public',
    $root_password = '12345',
    $password = '12345',
  ) {
    include php
    include apache
    apache::vhost { vhost: }
    class { 'mariadb': root_password => $root_password }
    mariadb::db::create { 'logindb': password => $password }
}
