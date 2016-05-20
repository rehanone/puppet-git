define git::user (
  $ensure       = present,
  $user_email   = 'you@yourdomain.com',
  $user_name    = 'Name',
  $color_ui     = true,
  $push_default = 'simple'
) {

  validate_re($ensure, [ '^present', '^absent' ], 'Must be present or absent')
  validate_email_address($user_email)
  validate_string($user_name)
  validate_bool($color_ui)
  validate_re($push_default, [ '^simple', '^matching' ], 'Push default can be set to simple or matching')

  $home = $name ? {
    'root'  => '/root',
    default => "/home/${name}"
  }

  $file_ensure = $ensure ? {
    'present' => file,
    default   => $ensure,
  }

  file { "${home}/.gitconfig":
    ensure  => $file_ensure,
    path    => "${home}/.gitconfig",
    owner   => $name,
    group   => $name,
    mode    => '0664',
    content => template("${module_name}/gitconfig.erb"),
    require => User[$name],
  }
}
