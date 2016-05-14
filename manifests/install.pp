# Class: git::install
#
class git::install inherits git {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if ! ($git::package_ensure in [ 'absent', 'held', 'installed', 'latest', 'present', 'purged' ]) {
    fail('package_ensure parameter must be one of absent, held, installed, latest, present, purged')
  }

  package { $git::package_name:
    ensure => $git::package_ensure,
    alias  => 'git',
  }
}
