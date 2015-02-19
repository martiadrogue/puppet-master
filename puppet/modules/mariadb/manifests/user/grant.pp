
define mariadb::user::grant ($user = $title, $host, $password, $database, $privileges = 'ALL PRIVILEGES') {

  exec { "mariadb::user::grant_privileges":
    command => "mysql -uroot -p${mariadb::root_password} -e \"GRANT ${privileges} ON ${database}.* TO '${user}'@'${host}' IDENTIFIED BY '${password}'; FLUSH PRIVILEGES;\"",
    path => $mariadb::bin,
    require => [
      Exec['root_password'],
      Exec["mariadb::db::create_${database}"]
    ],
  }

}
