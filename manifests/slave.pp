class buildbot::slave {
  buildbot::slave::instance {
    $buildbot::projects:
      project => $buildbot::projects,
  }
}
