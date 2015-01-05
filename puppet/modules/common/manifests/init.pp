
class common {

  $misc_packages = ['telnet', 'zip', 'unzip', 'git', 'screen', 'libssh2',
    'libssh2-devel', 'gcc', 'gcc-c++', 'autoconf', 'automake']

  package { $misc_packages: ensure => latest }

}
