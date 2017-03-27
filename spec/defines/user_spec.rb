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
    }
  },
  'root' => {
    params: { },
    expect: {
      ensure: 'present',
      user_email: 'you@yourcompany.com',
      user_name: 'Name',
      user_home: '/root',
      color_ui: 'true',
      push_default: 'simple',
    }
  },
}

describe 'git::user' do
  let(:facts) {{ :is_virtual => 'false' }}

  on_supported_os.select { |_, f| f[:os]['family'] != 'Solaris' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end


      testcases.each do |profile, values|

          let(:pre_condition) { [
            'contain git',
            'user{"user_default": }',
            'user{"root": }',
          ] }

          let(:facts) { {
            :os => { 'name' => 'Ubuntu' }
          } }

        context "testing #{profile}" do
          let(:title) { profile }
          let(:params) { values[:params] }

          it do
    #        should contain_file("#{values[:expect][:user_home]}/.gitignore")
    #          .with_ensure('file')
    #          .with_path("#{values[:expect][:user_home]}/.gitignore")
    #          .with_owner("#{title}")
    #          .with_group("#{title}")
    #          .with_mode('0644')
          end
        end
      end #testcases.each

    end
  end
end
