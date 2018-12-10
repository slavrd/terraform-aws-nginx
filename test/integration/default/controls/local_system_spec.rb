control 'local_system' do

  title 'Local System Tests'

  describe command('lsb_release -a') do
    its('stdout') { should match (/Ubuntu 16.04/) }
  end

  describe package('nginx') do
    it { should be_installed }
  end

  describe service('nginx') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end

  describe port(80) do
    it { should be_listening }
    its('protocols') { should include 'tcp' }
  end

  describe http('localhost:80') do
    its('status') { should eq 200 }
    its('body') { should match 'Welcome to nginx!' }
  end

end
