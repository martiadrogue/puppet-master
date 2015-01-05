class iptables(
    $config = $::iptables::params::config,
  ) inherits ::iptables::params {

  package { 'iptables':
    ensure => present,
    before => File['/etc/sysconfig/iptables'],
  }

  file { '/etc/sysconfig/iptables':
    ensure => file,
    owner => "root",
    group => "root",
    mode => 600,
    replace => true,
    source => "puppet://$::server/modules/iptables/etc/sysconfig/iptables-$config",
  }

  service { 'iptables':
    ensure     => running,
    enable     => true,
    subscribe  => File['/etc/sysconfig/iptables'],
  }

}
