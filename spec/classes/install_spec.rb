require 'spec_helper'

describe 'git::install', :type => :class do
  let :pre_condition do
      'class { "git": }'
  end

  let(:facts) { {
    :os => { 'name' => 'Ubuntu' }
  } }


  it { is_expected.to contain_package('git').with({
        'alias' => 'git',
     })
  }
end
