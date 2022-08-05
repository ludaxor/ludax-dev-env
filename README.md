##Dev Environment for testing playbooks in similar environment as the MLP servers. It has Eistools. The Vagrant box serves the playbook execution as well as the hosting of the 2 docker containers on which we can test Ansible Playbooks. There is one playbook bootstrap.yml for testing the setup.   

###Prerequisites:

Vagrant: https://www.vagrantup.com
VirtualBox: https://www.virtualbox.org

#https://github.com/hashicorp/vagrant/issues/8374
vagrant plugin install vagrant-vbguest
vagrant vbguest --do install --no-cleanup

#If stability is needed https://seven.centos.org/2017/09/updated-centos-vagrant-images-available-v1708-01/
#How to build vbguest in your image: https://gist.github.com/adaroobi/fea2727be6ae3d9c446767f813146f93
#Another box with vbguest in it.
##This plugin is for the usage of nfs

vagrant plugin install vagrant-winnfsd

https://stackoverflow.com/questions/45475023/configuring-vagrant-ca-certificates/45578945
#Extract the zscaler rootca from Microsoft Edge in base64 cer file. Open the content of the cert and copy and paste it in <path_to_vagrant>vagrant\embedded\cacert.pem at the end of the file. And it will 

SSL_CERT_FILE=/path/to/your/certs.pem

vagrant plugin install vagrant-vbguest

Important tool which can be used is: https://gitforwindows.org/

#In order to clone a repo you can use this command in the desired folder where you want it to place the repo:

git clone https://<your_github_personal_access_token>@github.dxc.com/MLP-Automations/MLP_Automation_Environment_DEV


##In order to login to the vagrant box you need to use command from the home directory of vagrant box - vagrant ssh 
## or through kitty/putty/mobaxterm .... use the private key .vagrant\machines\default\virtualbox\private_key with user vagrant

###Execution of Playbooks:

ansible-playbook -i hosts <playbook> -c docker

#In each of the playbook it is good to include the following line: 

hosts: docker 



