# To check the correct dependencies are set up for git.

require 'spec_helper'
describe 'git' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }
      describe 'Testing the dependancies between the classes' do
        it { is_expected.to contain_class('git::sources') }
        it { is_expected.to contain_class('git::install') }
        it { is_expected.to contain_class('git::config') }

        it { is_expected.to contain_class('git::sources').that_comes_before('Class[git::install]') }
        it { is_expected.to contain_class('git::install').that_comes_before('Class[git::config]') }
      end
    end
  end
end
