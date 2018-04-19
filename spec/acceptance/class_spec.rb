require 'spec_helper_acceptance'

describe 'git class:', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'git is expected to run successfully' do
    pp = "class { 'git': }"

    # Apply twice to ensure no errors the second time.
    apply_manifest(pp, catch_failures: true) do |r|
      expect(r.stderr).not_to match(%r{error}i)
    end
    apply_manifest(pp, catch_failures: true) do |r|
      expect(r.stderr).not_to eq(%r{error}i)

      expect(r.exit_code).to be_zero
    end
  end

  context 'sources_manage => present:' do
    it 'runs successfully' do
      pp = "class { 'git': sources_manage => true }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
    end
  end

  context 'package_ensure => present:' do
    it 'runs successfully' do
      pp = "class { 'git': package_ensure => present }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
    end
  end
end
