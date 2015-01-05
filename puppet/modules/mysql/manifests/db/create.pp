
define mysql::db::create (
    $dbname = $title,
    $user = "${title}_root",
    $password = "",
  ) {

  exec { "mysql::db::create_${dbname}":
    command => "mysql -uroot -p${mysql::root_password} -e \"CREATE DATABASE IF NOT EXISTS ${dbname}\"",
    path => $mysql::bin,
    require => Exec['root_password'],
  }

  mysql::user::grant { $user:
    host     => 'localhost',
    password => '12345',
    database => $dbname,
  }

}
