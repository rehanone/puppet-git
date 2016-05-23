require 'spec_helper'
describe 'git::params', :type => :class do

  let(:facts) { {
    :os => { 'name' => 'Ubuntu' }
  } }

  it { is_expected.to contain_git__params }

  it "Should not contain any resources" do
    expect(subject.call.resources.size).to eq(4)
  end
end
