define git::user (
  Enum[present, absent]
          $ensure       = present,
  String  $user_email   = 'you@yourdomain.com',
  String  $user_name    = 'Name',
  String  $user_home    = $title ? {
    'root'  => '/root',
    default => "/home/${title}"
  },
  Boolean $color_ui     = true,
  Enum[simple, matching, upstream]
          $push_default = simple
) {

  $file_ensure = $ensure ? {
    present => file,
    default => $ensure,
  }

  file { "${user_home}/.gitconfig":
    ensure  => $file_ensure,
    path    => "${user_home}/.gitconfig",
    owner   => $title,
    group   => $title,
    mode    => '0664',
    content => template("${module_name}/gitconfig.erb"),
    require => User[$title],
  }
}
