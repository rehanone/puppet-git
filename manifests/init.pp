# Class: git
#
class git (
  $sources_manage = $git::params::sources_manage,
  $sources_repo   = $git::params::sources_repo,
  $package_ensure = $git::params::package_ensure,
  $package_name   = $git::params::package_name,
  $users          = hiera_hash('git::users', {}),
) inherits git::params {

  validate_bool($sources_manage)
  validate_string($sources_repo)
  validate_string($package_ensure)
  validate_string($package_name)
  validate_hash($users)

  anchor { "${module_name}::begin": } ->
  class { "${module_name}::sources": } ->
  class { "${module_name}::install": } ->
  class { "${module_name}::config": } ->
  anchor { "${module_name}::end": }
}
