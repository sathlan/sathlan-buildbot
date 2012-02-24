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
  }
  # check this to understand the underlying logic:
  # Handling_Disparate_Defines_With_Classes_Patterns
  # on http://projects.puppetlabs.com/projects/1/wiki/
  buildbot::instance {
    $buildbot::projects:
      project => $buildbot::projects,
  }
}
