require 'spec_helper'

describe 'git::sources', :type => :class do
  let :pre_condition do
      'class { "git": sources_manage => true }'
  end

  let(:facts) { {
    :os => { 'name' => 'Ubuntu' },
    :osfamily => 'Debian',
    :puppetversion => '4.0.0',
    :lsbdistid => 'debian'
  } }


  it do
      expect {
        is_expected.to contain_class('apt::ppa')
      }.to raise_error(Puppet::PreformattedError, /deprecation. validate_hash. This method is deprecated/)
  end

#  it { is_expected.to have_apt_ppa_resource_count(1) }

#  it { is_expected.to contain_class('apt::ppa') }
end
