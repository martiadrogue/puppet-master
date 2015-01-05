
define mysql::user::grant ($user = $title, $host, $password, $database, $privileges = 'ALL PRIVILEGES') {

  exec { "mysql::user::grant_privileges":
    command => "mysql -uroot -p${mysql::root_password} -e \"GRANT ${privileges} ON ${database}.* TO '${user}'@'${host}' IDENTIFIED BY '${password}'; FLUSH PRIVILEGES;\"",
    path => $mysql::bin,
    require => [
      Exec['root_password'],
      Exec["mysql::db::create_${database}"]
    ],
  }

}
