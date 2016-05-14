# Class: git::params
#
class git::params {
  $sources_manage  = false
  $sources_repo    = 'ppa:git-core/ppa'
  $package_ensure  = 'latest'
  $package_name    = 'git'
}
