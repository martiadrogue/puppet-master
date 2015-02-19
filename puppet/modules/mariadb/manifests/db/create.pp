
define mariadb::db::create (
    $dbname = $title,
    $user = "${title}_root",
    $password = "",
  ) {

  exec { "mariadb::db::create_${dbname}":
    command => "mysql -uroot -p${mariadb::root_password} -e \"CREATE DATABASE IF NOT EXISTS ${dbname}\"",
    path => $mariadb::bin,
    require => Exec['root_password'],
  }

  mariadb::user::grant { $user:
    host     => 'localhost',
    password => '12345',
    database => $dbname,
  }

}
