define buildbot::config::project::instance($project) {
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
    '/etc/default/buildbot':
      ensure  => file,
      source  => template('buildbot/default.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644';
    '/etc/init.d/vboxload':
      ensure  => file,
      source  => 'puppet:///modules/buildbot/vboxload',
      owner   => 'root',
      group   => 'root',
      mode    => '0755';
  }
  # check this to understand the underlying logic:
  # http://projects.puppetlabs.com/projects/1/wiki/Handling_Disparate_Defines_With_Classes_Patterns
  buildbot::config::project::instance {
    $buildbot::projects:
      project => $buildbot::projects,
  }
}
