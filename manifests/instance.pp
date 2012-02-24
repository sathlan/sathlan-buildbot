define buildbot::instance($project) {
  file {
    "/home/$buildbot::user/$project":
      ensure => directory,
      group  => $buildbot::user,
      mode   => '0755',
      owner  => $buildbot::user;
    "/home/$buildbot::user/$project/info/admin":
      ensure  => file,
      content => "$buildbot::admin <$buildbot::mail>",
      owner   => $buildbot::user,
      group   => $buildbot::user,
      mode    => '0755';
    "/home/$buildbot::user/$project/info/host":
      ensure  => file,
      content => "VBox based on Debian 6.  Can run tests with VBox Creation.\n",
      owner   => $buildbot::user,
      group   => $buildbot::user,
      mode    => '0755';
  }
}
