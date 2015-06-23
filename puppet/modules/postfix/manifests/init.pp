class postfix(
    $myhostname = $hostname,
    $mydomain = $domain,
    $username = '',
    $password = '',
    $home_mailbox = $::postfix::params::home_mailbox,
  ) inherits ::postfix::params {

  $packages = ['postfix', 'dovecot']

  package { $packages:
    ensure => present,
    before => File[$home_mailbox]
  }

  file { $home_mailbox:
      ensure => "directory",
      owner => 'root',
      group => 'root',
      notify => File['/etc/dovecot/conf.d/10-auth.conf']
  }

  file { '/etc/dovecot/conf.d/10-auth.conf':
      ensure => "file",
      owner => 'root',
      group => 'root',
      mode => '0644',
      source => "puppet://$::server/modules/postfix/etc/dovecot/conf.d/10-auth.conf",
      notify => File['/etc/dovecot/conf.d/10-master.conf']
  }

  file { '/etc/dovecot/conf.d/10-master.conf':
      ensure => "file",
      owner => 'root',
      group => 'root',
      mode => '0644',
      source => "puppet://$::server/modules/postfix/etc/dovecot/conf.d/10-master.conf",
      notify => File['/etc/dovecot/conf.d/20-pop3.conf']
  }

  file { '/etc/dovecot/conf.d/20-pop3.conf':
      ensure => "file",
      owner => 'root',
      group => 'root',
      mode => '0644',
      source => "puppet://$::server/modules/postfix/etc/dovecot/conf.d/20-pop3.conf",
      notify => File['/etc/postfix/master.cf']
  }

  file { '/etc/postfix/master.cf':
      ensure => "file",
      owner => 'root',
      group => 'root',
      mode => '0644',
      source => "puppet://$::server/modules/postfix/etc/postfix/master.cf",
      notify => File['/etc/dovecot/conf.d/10-mail.conf']
  }

  file { '/etc/dovecot/conf.d/10-mail.conf':
      ensure => "file",
      owner => 'root',
      group => 'root',
      mode => '0644',
      content => template("postfix/etc/dovecot/conf.d/10-mail.conf.erb"),
      notify => File['/etc/postfix/main.cf']
  }

  file { '/etc/postfix/main.cf':
      ensure => "file",
      owner => 'root',
      group => 'root',
      mode => '0644',
      content => template("postfix/etc/postfix/main.cf.erb")
  }

  user { $username:
      ensure => "present",
      password => $password,
      shell => '/sbin/nologin'
  }

  service { $packages:
    ensure => running,
    enable => true,
    subscribe => File['/etc/postfix/main.cf']
  }
}
