# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
	# The most common configuration options are documented and commented below.
	# For a complete reference, please see the online documentation at
	# https://docs.vagrantup.com.

	# Every Vagrant development environment requires a box. You can search for
	# boxes at https://vagrantcloud.com/search.
	config.vm.box = "boxcutter/ubuntu1604"

	# The url from where the 'config.vm.box' box will be fetched if it
	# doesn't already exist on the user's system.
	config.vm.box_url = "https://app.vagrantup.com/boxcutter/boxes/ubuntu1604"

	# memory increase
	config.vm.provider "virtualbox" do |v|
        v.memory = 4964
        v.cpus = 4
    end
					  
	PATH_VAGRANT_PROJECT=File.dirname(__FILE__)
	
	
	# aws configs
	config.vm.provision "file", source: "#{PATH_VAGRANT_PROJECT}\\vagrant-configs\\.aws\\config", destination: "/home/vagrant/.aws/config"
	config.vm.provision "file", source: "#{PATH_VAGRANT_PROJECT}\\vagrant-configs\\.aws\\credentials", destination: "/home/vagrant/.aws/credentials"



	
	# forward ports
	# jenkins
	config.vm.network :forwarded_port, guest: 8080, host: 8080
	config.vm.network :forwarded_port, guest: 50000, host: 50000
	
	# ldap
	config.vm.network :forwarded_port, guest: 389, host: 389
	config.vm.network :forwarded_port, guest: 8081, host: 8081
	config.vm.network :forwarded_port, guest: 636, host: 636
	config.vm.network :forwarded_port, guest: 8082, host: 8082
	

	
	# all files here will be added to home
	config.vm.synced_folder "vagrant-home/", "//root/vagrant-home/"
	
  
	# Use shell script to provision
	config.vm.provision "shell", inline: <<-SHELL
			
	
		# update
		apt-get update	
		
		
		###############
		##### DOCKER
		
		# install docker
		apt-get -y install docker.io
		
		
		
		###############
		##### AWS
		
		apt-get -y install awscli
		sudo mv /vagrant/.aws /root/
		
		
		
		
		
		###############
		##### RESTORE BACKUPS		
				###############
		##### RESTORE BACKUPS		
		bash /root/vagrant-home/backup-RestoreFromS3.sh
		


		###############
		##### LDAP
		bash ./openldap-start.sh		
		
		
		###############
		##### JENKINS			
		
		# make sure my docker image "schajtan/jenkins" exists
		cd /root/vagrant-home/
			
		# start jenkins from my jenkins
		bash ./jenkins-container-start.sh
			

	SHELL
  
end
