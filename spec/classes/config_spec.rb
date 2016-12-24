require 'spec_helper'

describe 'git::config', :type => :class do
  let :pre_condition do
      'class { "git": sources_manage => false }'
  end

  let(:facts) { {
    :os => { 'name' => 'Ubuntu' },
    :osfamily => 'Debian',
    :puppetversion => '4.0.0',
    :lsbdistid => 'debian'
  } }


  it { is_expected.to have_resource_count(3) }

  it { is_expected.to have_class_count(5) }

  it { is_expected.to have_git_user_resource_count(0) }

end
