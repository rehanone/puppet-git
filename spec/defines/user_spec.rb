require 'spec_helper'

testcases = {
  'user_default' => {
    params: {
      user_home: '/home/user_default',
    },
    expect: {
      ensure: 'present',
      user_email: 'you@yourcompany.com',
      user_name: 'Name',
      user_home: '/home/user_default',
      color_ui: 'true',
      push_default: 'simple',
    },
  },
  'root' => {
    params: {},
    expect: {
      ensure: 'present',
      user_email: 'you@yourcompany.com',
      user_name: 'Name',
      user_home: '/root',
      color_ui: 'true',
      push_default: 'simple',
    },
  },
}

describe 'git::user' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      testcases.each do |profile, values|
        let(:pre_condition) do
          [
            'contain git',
            'user{"user_default": }',
            'user{"root": }',
          ]
        end

        context "testing #{profile}" do
          let(:title) { profile }

          it {
            is_expected.to contain_file("#{values[:expect][:user_home]}/.gitconfig")
              .with_ensure('file')
              .with_path("#{values[:expect][:user_home]}/.gitconfig")
              .with_owner(title)
              .with_group(title)
              .with_mode('0644')
          }
        end
      end
    end
  end
end
