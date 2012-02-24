define buildbot::slave::instance($project) {
  Exec {
    path => [ '/bin', '/usr/bin',
              '/usr/sbin', '/sbin',
              '/usr/local/bin', '/usr/local/sbin'
              ],
  }
  exec { 'basic-init':
    command => "buildbot create-slave $project \
$buildbot::master_ip $buildbot::master_pass",
    cwd     => "/home/$buildbot::user",
    group   => $buildbot::user,
    user    => $buildbot::user,
    creates => "/home/$buildbot::user/$project/buildbot.tac",
    require => Class['buildbot::config'],
  }
}
