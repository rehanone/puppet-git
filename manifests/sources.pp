
class git::sources {

  # assert_private("Use of private class ${name} by ${caller_module_name}")

  case $::osfamily {
    'Ubuntu': {
      contain apt
      apt::ppa { $git::sources_repo:
        ensure => present,
      }
    }
    'RedHat': { }
    'Archlinux': { }
    default: {}
  }
}
