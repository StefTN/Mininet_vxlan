##################### KTR Information ###########################
# With the help of the tool Vagrant (https://www.vagrantup.com) #
# you can use this file to create a Virtualbox Image with       # 
# Mininet (http://mininet.org/).                                #
#                                                               #
#                                                               #
# AUTHOR    Stefano Maurina <stefano.maurina@pm.me>   			#
# CREATION  07.2020                                          	# 
# LAST_MOD  07.2020                                          	# 
##################### KTR Information ###########################

Vagrant.configure("2") do |config|
    config.vm.box = "ktr/mininet"
    config.vm.box_version = "1.3.0"

    simid = 100

    config.vm.provider "virtualbox" do |v|
        v.gui=false
        v.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
        v.customize ["modifyvm", :id, "--cpus", "2"]
        v.customize ["modifyvm", :id, "--memory", "2048"]
        v.customize ["modifyvm", :id, "--nictype1", "virtio"]
        v.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all', "--nictype2", "virtio"]
    end

    # Run the Config specified in the Node Attributes
    config.vm.provision :shell , path: "./helper_scripts/config_mininet_vm.sh"
    

    ##### DEFINE VM for mininet1 #####
    config.vm.define "mininet1" do |device|
    
        device.vm.hostname = "mininet1" 
       
        # Flavor
        device.vm.provider "virtualbox" do |v|
            v.name = "#{simid}_mininet1"
            
        end

        # Currently use a private IP for the box
        device.vm.network "private_network", ip: "192.168.56.91"
		
		# Run the Config specified in the Node Attributes
		device.vm.provision :shell , path: "./helper_scripts/mininet_vm1.sh"
    end

    ##### DEFINE VM for mininet2 #####
    config.vm.define "mininet2" do |device|
        
        device.vm.hostname = "mininet2" 

        # Flavor
        device.vm.provider "virtualbox" do |v|
            v.name = "#{simid}_mininet2"
        end


        # Currently use a private IP for the box
        device.vm.network "private_network", ip: "192.168.56.92"
		
		# Run the Config specified in the Node Attributes
		device.vm.provision :shell , path: "./helper_scripts/mininet_vm2.sh"
    end    

    ##### DEFINE VM for mininet_3 #####
    config.vm.define "mininet3" do |device|
    
        device.vm.hostname = "mininet3" 
  
        # Flavor
        device.vm.provider "virtualbox" do |v|
            v.name = "#{simid}_mininet3"
        end

        # Currently use a private IP for the box
        device.vm.network "private_network", ip: "192.168.56.93"
		
		# Run the Config specified in the Node Attributes
		device.vm.provision :shell , path: "./helper_scripts/mininet_vm3.sh"
    end
end