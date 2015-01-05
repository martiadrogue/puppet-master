
class remi-mysql {

  package { 'mysql-community':
    provider => rpm,
    ensure => installed,
    install_options => ['-vh', '--replacepkgs'],
    source => 'http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm',
  }

}
