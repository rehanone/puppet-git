node default {
  notify { 'enduser-before': }
  notify { 'enduser-after': }

  user { 'vagrant': }
  user { 'root': }

  class { 'git':
    sources_manage => true,
    users          => {
      'vagrant' => {},
      'root'    => {
        user_email => 'test@test.com',
        gitconfig  => {
          'pull' => {
            'merge' => true,
          },
        },
      },
    },
    require        => Notify['enduser-before'],
    before         => Notify['enduser-after'],
  }
}
