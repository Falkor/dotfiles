# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # (nearly) All below boxes were generated using [vagrant-vms](https://github.com/Falkor/vagrant-vms/)
  {
   :centos_7 => {
                 :box => "svarrette/centos-7-puppet",
                 :url => "https://atlas.hashicorp.com/svarrette/boxes/centos-7-puppet"
                },
   :debian_7 => {
                 :box     => "svarrette/debian-7-puppet",
                 :url     => "https://atlas.hashicorp.com/svarrette/debian-7-puppet",
                 :primary => true
                }
  }.each do |name,cfg|
    boxname = name.to_s.downcase.gsub(/_/, '-')
    config.vm.define boxname, :autostart => (! cfg[:primary].nil?), :primary => cfg[:primary] do |local|
      #local.vm.primary = true if cfg[:primary]
      local.vm.box = cfg[:box]
      local.vm.host_name = ENV['VAGRANT_HOSTNAME'] || name.to_s.downcase.gsub(/_/, '-').concat(".vagrant.com")
    end
  end
end
