# feature-2 comment
Vagrant.configure("2") do |config|
  config.vm.define "webserver" do |vm1|
    vm1.vm.box = "ubuntu/jammy64"
    vm1.vm.network "forwarded_port", guest: 8080, host: 80
    vm1.vm.network "public_network"
    vm1.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
    end
  end
  config.vm.define "webserver2" do |vm2|
    vm2.vm.box = "centos/7"
    vm2.vm.network "forwarded_port", guest: 8080, host: 82
    vm2.vm.network "public_network"
    vm2.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
    end
  end
   config.vm.define "webserver3" do |vm3|
     vm3.vm.box = "generic/fedora28"
     vm3.vm.network "forwarded_port", guest: 8080, host: 84
     vm3.vm.network "public_network"
     vm3.vm.provider "virtualbox" do |vb|
       vb.memory = "1024"
       vb.cpus = 1
     end
   end
end
