class buildbot::config {
  File {
    require => Class['buildbot::install'],
    notify  => Class['buildbot::service'],
  }
  file {
    "/home/$buildbot::user/":
      ensure => directory,
      group  => $buildbot::user,
      mode   => '0755',
      owner  => $buildbot::user;
    "/home/$buildbot::user/buildbot":
      ensure => directory,
      group  => $buildbot::user,
      mode   => '0755',
      owner  => $buildbot::user;
    '/etc/default/buildbot':
      ensure  => file,
      source  => template('buildbot/default'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644';
    '/etc/init.d/vboxload':
      ensure  => file,
      source  => 'puppet:///modules/buildbot/vboxload',
      owner   => 'root',
      group   => 'root',
      mode    => '0755';
    "/home/$buildbot::user/buildbot/info/admin":
      ensure  => file,
      content => "$buildbot::admin <$buildbot::mail>",
      owner   => $buildbot::user,
      group   => $buildbot::user,
      mode    => '0755';
    "/home/$buildbot::user/buildbot/info/host":
      ensure  => file,
      content => "VBox based on Debian 6.  Can run tests with VBox Creation.\n",
      owner   => $buildbot::user,
      group   => $buildbot::user,
      mode    => '0755';
  }
}
