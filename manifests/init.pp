# == Class: buildbot
#
# Full description of class buildbot here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { buildbot:
#    ...
#  }
#
# === Authors
#
# Sofer Athlan <mypublicaddress-code@ymail.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class buildbot(
  $projects=[],
  $type='slave',
  $ensure='running',
  $user='bbslave',
  $mail='buildbot@example.com',
  $admin='admin',
  $master_ip='192.168.0.2',
  $master_pass='pass1') {
    include 'buildbot::install', 'buildbot::service',
      'buildbot::config', "buildbot::$type"
}
