# Class: git::params
#
class git::params {
  $sources_manage  = false
  $sources_repo    = $::facts[os][name] ? {
    'Ubuntu' => 'ppa:git-core/ppa',
    default  => '',
  }
  $sources_ensure  = present
  $package_manage  = true
  $package_ensure  = latest
  $package_name    = 'git'
}
