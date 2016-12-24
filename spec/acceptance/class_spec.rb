require 'spec_helper_acceptance'

describe 'git class:', :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'should run successfully' do
    pp = "class { 'git': }"

    # Apply twice to ensure no errors the second time.
    apply_manifest(pp, :catch_failures => true) do |r|
      expect(r.stderr).not_to match(/error/i)
    end
    apply_manifest(pp, :catch_failures => true) do |r|
      expect(r.stderr).not_to eq(/error/i)

      expect(r.exit_code).to be_zero
    end
  end

  context 'sources_ensure => present:' do
    it 'runs successfully' do
      pp = "class { 'git': sources_manage => true, sources_ensure => present, }"

      apply_manifest(pp, :catch_failures => true) do |r|
        expect(r.stderr).not_to match(/error/i)
      end
    end
  end

  context 'sources_ensure => absent:' do
    it 'runs successfully' do
      pp = "class { 'git': sources_manage => true, sources_ensure => absent, }"

      apply_manifest(pp, :catch_failures => true) do |r|
        expect(r.stderr).not_to match(/error/i)
      end
    end
  end

  context 'package_ensure => present:' do
    it 'runs successfully' do
      pp = "class { 'git': package_ensure => present }"

      apply_manifest(pp, :catch_failures => true) do |r|
        expect(r.stderr).not_to match(/error/i)
      end
    end
  end
end
