# == Class: buildbot
#
# This module manage builbot slave/master.
#
# Tested plateforms:
#  - Debian 6.0 Squeeze
#    - puppet 2.7.10
#
#
# run "rake spec" to check that everything works for you.  Requires:
#  - ruby 1.9
#  - rspec-puppet
#  - mocha
#
# === Parameters
#
# ==== For slave
#  - $projects=[]                 : an array of projects this slave is used for.
#  - $type='slave'                : type of configuration : master/slave
#  - $ensure='running'            : running, stopped. TODO: only running works.
#  - $user='bbslave'              : user used to run the bot.
#  - $mail='buildbot@example.com' : mail of the administration.
#  - $admin='admin'               : real name of the administration.
#  - $master_ip='192.168.0.2',    : the master ip.
#  - $master_pass='pass1',        : the used password.
#
#
# ==== For master: TODO: NOT WORKING YET
#  $slaves=[],                  : an array of slaves.
#  $passwords=[],               : the associated password.
#  $gitsource='',               : the source of the project.
#  $subproject_names=[],        : subproject.
#  $proj_title='',              : name of the project.
#  $url='',                     : url of the project.
#  $slave_listen='',            : port where the slave will connect.
#  $listen='',                  : port where the admin panel will listen.
#  $try_scheduler=[],           : user/passwd for the try.
#
#
# === Variables
#
# No varible required.
#
# === Examples
#
# ==== For a slave
# class buildbot(
#        projects: ['compile_stuff'],
#        user:    'buildbot',
#        admin:   'alice',
#        mail:    'alice@dot.com',
#        master_ip: '192.168.0.8',
#        master_pass: 'my_pass')
#
# === Authors
#
# Sofer Athlan <mypublicaddress-code@ymail.com>
#
# === Copyright
#
# This software is Copyright (c) 2012 by sathlan.
#
# This is free software, licensed under:
#
#  The GNU Lesser General Public License, Version 3, June 2007
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
