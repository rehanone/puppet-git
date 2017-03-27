# To check the correct dependencies are set up for git.

require 'spec_helper'
describe 'git' do
  let(:facts) {{ :is_virtual => 'false' }}

  on_supported_os.select { |_, f| f[:os]['family'] != 'Solaris' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      it { is_expected.to compile.with_all_deps }
      describe "Testing the dependancies between the classes" do
        it { should contain_class('git::sources') }
        it { should contain_class('git::install') }
        it { should contain_class('git::config') }

        it { is_expected.to contain_class('git::sources').that_comes_before('Class[git::install]') }
        it { is_expected.to contain_class('git::install').that_comes_before('Class[git::config]') }
      end
    end
  end
end