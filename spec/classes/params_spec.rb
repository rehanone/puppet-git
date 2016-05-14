require 'spec_helper'
describe 'git::params', :type => :class do

  it { is_expected.to contain_git__params }

  # There are 4 resources in this class currently
  # there should not be any more resources because it is a params class
  # The resources are class[apt::params], class[main], class[settings], stage[main]
  it "Should not contain any resources" do
    expect(subject.call.resources.size).to eq(4)
  end
end
