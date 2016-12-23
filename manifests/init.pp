# Class: git
#
class git (
  Boolean $sources_manage = $git::params::sources_manage,
  String  $sources_repo   = $git::params::sources_repo,
  String  $sources_ensure = $git::params::sources_ensure,
  String  $package_ensure = $git::params::package_ensure,
  String  $package_name   = $git::params::package_name,
  Hash[String, Hash[String, String]]
          $users = hiera_hash('git::users', {}),
) inherits git::params {
  anchor { "${module_name}::begin": } ->
    class { "${module_name}::sources": } ->
    class { "${module_name}::install": } ->
    class { "${module_name}::config": } ->
  anchor { "${module_name}::end": }
}
