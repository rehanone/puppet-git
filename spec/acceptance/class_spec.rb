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

  context 'package_ensure => present:' do
    it 'runs successfully to ensure package is installed' do
      pp = "class { 'git': package_ensure => present }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
    end
  end

  context 'users => hash:' do
    it 'runs successfully and create a git profile' do
      pp = %q(
        user {'root': }
        class { 'git':
          package_ensure => present,
          users => {
            'root' => {
              user_email => 'a@a.co',
              user_name => "Rehan Mahmood",
            }
          }
        }
      )

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
      shell('test -e /root/.gitconfig')
    end
  end

  context 'package_ensure => absent:' do
    it 'runs successfully to ensure package is uninstalled' do
      pp = "class { 'git': package_ensure => absent }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
    end
  end
end
