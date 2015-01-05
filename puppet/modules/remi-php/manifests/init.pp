
class remi-php {

  $repo = [ 'https://mirror.webtatic.com/yum/el7/epel-release.rpm',
    'https://mirror.webtatic.com/yum/el7/webtatic-release.rpm' ]

  package { "epel-release":
    provider => rpm,
    ensure => present,
    install_options => ['-vh', '--replacepkgs'],
    source => 'https://mirror.webtatic.com/yum/el7/epel-release.rpm',
  }

  package { "webtatic-release":
    provider => rpm,
    ensure => present,
    install_options => ['-vh', '--replacepkgs'],
    source => 'https://mirror.webtatic.com/yum/el7/webtatic-release.rpm',
  }

}
