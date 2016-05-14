# Class: git::sources
#
class git::sources {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $git::sources_manage {

    case $::facts['osfamily'] {
      'Ubuntu': {
        contain apt
        apt::ppa { $git::sources_repo:
          ensure => $git::sources_ensure,
        }
      }
      'RedHat': { }
      default: { }
    }
  }
}
