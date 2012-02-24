class buildbot::install {
  package { 'git-core':
    ensure => present,
  }
  package { 'buildbot':
    ensure => present,
  }

  # group bbslave is automatically created on debian.
  user { $buildbot::user:
    ensure     => present,
    comment    => 'buildbot user',
    home       => "/home/$buildbot::user",
    managehome => true,
    name       => $buildbot::user,
    groups     => [$buildbot::user, 'sudo'],
  }
}
