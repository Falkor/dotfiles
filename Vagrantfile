# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # (nearly) All below boxes were generated using [vagrant-vms](https://github.com/Falkor/vagrant-vms/)
  {
   :centos => 'centos/7',
   :debian => 'debian/contrib-jessie64',
   :ubuntu => 'ubuntu/trusty64'
  }.each do |os,name|
    boxname = os.to_s.downcase.gsub(/_/, '-')
    # Only the Ubuntu box is booted by default
    config.vm.define boxname, :autostart => (os =~ /ubuntu/), :primary => (os =~ /ubuntu/) do |local|
      local.vm.box = name
      local.vm.host_name = ENV['VAGRANT_HOSTNAME'] || boxname.concat(".vagrant.com")
    end
  end
end
