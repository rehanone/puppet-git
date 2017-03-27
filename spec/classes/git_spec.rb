require 'spec_helper'

describe 'git' do
  let(:facts) {{ :is_virtual => 'false' }}

  on_supported_os.select { |_, f| f[:os]['family'] != 'Solaris' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      it { is_expected.to compile.with_all_deps }

      it { should contain_class('git::sources') }
      it { should contain_class('git::install') }
      it { should contain_class('git::config') }

      describe "git::config" do
        it { is_expected.to have_resource_count(3) }
      end

      describe 'git::install' do
        let(:params) {{ :package_ensure => 'present', :package_name => 'git', :package_manage => true, }}

        it { should contain_package('git').with(
          :ensure => 'present'
        )}

        describe 'should allow package ensure to be overridden' do
          let(:params) {{ :package_ensure => 'latest', :package_name => 'git', :package_manage => true, }}
          it { should contain_package('git').with_ensure('latest') }
        end

        describe 'should allow the package name to be overridden' do
          let(:params) {{ :package_ensure => 'present', :package_name => 'hambaby', :package_manage => true, }}
          it { should contain_package('hambaby') }
        end

        describe 'should allow the package to be unmanaged' do
          let(:params) {{ :package_manage => false, :package_name => 'git', }}
          it { should_not contain_package('git') }
        end
      end

    end
  end
end
