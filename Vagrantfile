Vagrant.configure("2") do |config|
  # Ensure virtualbox guest plugins are installed and latest
  config.vagrant.plugins = ["vagrant-vbguest"]
  

  # Install vagrant-disksize to allow resizing the vagrant box disk.
  unless Vagrant.has_plugin?("vagrant-disksize")
      raise  Vagrant::Errors::VagrantError.new, "vagrant-disksize plugin is missing. Please install it using 'vagrant plugin install vagrant-disksize' and rerun 'vagrant up'"
  end
  #It need disksize plugin to be installed in vagrant - vagrant plugin install vagrant-disksize
  #In order to expand the disksize in unix - 
  #Run sudo cfdisk /dev/sda
  #Use arrows to select your disk probably sdaX. Mine was sda3.
  #Then select resize using arrow keys. Accept the suggested disk size.
  #Then select write. And answer yes.
  #You can select quit now.
  #sudo resize2fs -p -F /dev/sdaX    -  where X is the number of the disk. If this not works try with the next one
  #sudo xfs_growfs /dev/sdaX


  # VM Properties
  config.vm.define "ludax1" do |ludax1|
  # Box
    ludax1.vm.box = "ludax/centos8"
    ludax1.disksize.size = '20GB'
	ludax1.vm.hostname = "ludax-dev-env"
	ludax1.vm.network :private_network, ip: "192.168.10.66"
	ludax1.vm.network "forwarded_port", guest: 22, host: 6666
    # Install Mock
    ludax1.vm.provision "shell", inline: <<-SHELL
      sudo dnf update -y
	  sudo yum install firefox net-tools mesa-libGL libEGL -y
    SHELL
    
    # Force Virtualbox sync
    ludax1.vm.synced_folder ".", "/vagrant", type: "virtualbox"
    
    # VBox Guest options
    ludax1.vbguest.auto_update = true
    ludax1.vbguest.installer_options = { allow_kernel_upgrade: true }
    ludax1.vbguest.installer_hooks[:before_start] = [
      "echo 'vboxsf' > /etc/modules-load.d/vboxsf.conf", 
      "systemctl restart systemd-modules-load.service", 
      "echo '=== Verifying vboxsf module is loaded'", 
      "cat /proc/modules | grep vbox" 
    ]

	
	ludax1.vm.provider :virtualbox do |v|
	  v.customize ["modifyvm", :id, "--memory", 2096]
	  v.customize ["modifyvm", :id, "--name", "ludax1"]
	end

  end
  config.vm.provision "shell", path: "bootstrap.sh" 
end