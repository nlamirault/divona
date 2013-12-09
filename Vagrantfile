# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define :travis do |travis_config|
    travis_config.vm.box = "lucid32"
    travis_config.vm.box_url = "http://files.vagrantup.com/lucid32.box"
    travis_config.vm.hostname = "TravisCI"

    travis_config.vm.network :private_network, :ip => '10.10.0.201'
    # Assign this VM to a host-only network IP, allowing you to access it
    # via the IP. Host-only networks can talk to the host machine as well as
    # any other machines on the same network, but cannot be accessed (through this
    # network interface) by any external networks.
    # travis_config.vm.network :hostonly, "172.16.0.201"
    # travis_config.vm.network :hostonly, "10.10.0.201"

    travis_config.ssh.forward_agent = true
    travis_config.ssh.forward_x11 = true

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    # config.vm.synced_folder "../data", "/vagrant_data"

    travis_config.vm.provider :virtualbox do |vb|
      #vb.gui = true
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.name = "TravisCI"
    end

    travis_config.vm.provision :ansible do |ansible|
      ansible.playbook = "ansible/travis.yml"
      ansible.inventory_file = "ansible/travis_hosts"
      ansible.options = '-vv'
    end

  end

end
