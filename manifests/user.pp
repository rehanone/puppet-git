# git::user
#
define git::user (
  Enum[present, absent]   $ensure = present,
  String  $user_email             = 'you@yourdomain.com',
  String  $user_name              = 'Name',
  String  $user_home              = $title ? {
    'root'  => '/root',
    default => "/home/${title}"
  },
  Hash[
    String,
    Hash[String, Variant]
  ] $gitconfig                    = {},
) {

  $file_ensure = $ensure ? {
    'present' => file,
    default   => $ensure,
  }

  if $gitconfig.empty {
    $config = lookup('git::default_gitconfig', Hash, 'hash', {})
  } else {
    $config = $gitconfig
  }

  file { "${user_home}/.gitconfig":
    ensure  => $file_ensure,
    path    => "${user_home}/.gitconfig",
    owner   => $title,
    group   => $title,
    mode    => '0644',
    content => epp("${module_name}/gitconfig.epp",
      {
        'user_email' => $user_email,
        'user_name'  => $user_name,
        'gitconfig'  => $config,
      }
    ),
    require => User[$title],
  }
}
