require 'spec_helper'
describe 'git' do

  let(:facts) { {
    :os => { 'name' => 'Ubuntu' }
  } }

  it { should compile }

  context 'with default values for all parameters' do
    it { should contain_class('git::sources') }
    it { should contain_class('git::install').that_requires('Git::Sources') }
    it { should contain_class('git::config').that_requires('Git::Install') }
  end
end
