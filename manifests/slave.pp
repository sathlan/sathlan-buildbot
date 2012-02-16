class buildbot::slave {
  exec { 'basic-init':
    command => "buildbot create-slave $buildbot::project $buildbot::master_ip $buildbot::master_pass",
    cwd     => "/home/$buildbot::user",
    group   => $buildbot::user,
    user    => $buildbot::user,
    creates => "/home/$buildbot::user/$buildbot::project/buildbot.tac",
    path    => [ '/bin', '/usr/bin',
              '/usr/sbin', '/sbin',
              '/usr/local/bin', '/usr/local/sbin'
              ],
    require => Class['buildbot::config'],
  }
}
