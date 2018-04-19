require 'spec_helper'

describe 'git' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('git::sources') }
      it { is_expected.to contain_class('git::install') }
      it { is_expected.to contain_class('git::config') }

      describe 'git::config' do
        it { is_expected.to have_resource_count(3) }
      end

      describe 'git::install' do
        let(:params) do
          {
            package_ensure: 'present',
            package_name: 'git',
            package_manage: true,
          }
        end

        it {
          is_expected.to contain_package('git').with_ensure('present')
        }

        describe 'should allow package ensure to be overridden' do
          let(:params) do
            {
              package_ensure: 'latest',
              package_name: 'git',
              package_manage: true,
            }
          end

          it {
            is_expected.to contain_package('git').with_ensure('latest')
          }
        end

        describe 'should allow the package name to be overridden' do
          let(:params) do
            {
              package_ensure: 'present',
              package_name: 'hambaby',
              package_manage: true,
            }
          end

          it {
            is_expected.to contain_package('hambaby')
          }
        end

        describe 'should allow the package to be unmanaged' do
          let(:params) do
            {
              package_manage: false,
              package_name: 'git',
            }
          end

          it {
            is_expected.not_to contain_package('git')
          }
        end
      end
    end
  end
end
