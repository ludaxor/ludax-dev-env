#!/bin/bash -xv

export AUTO="/LUDAX_Automation"
#export EIS="EISTools_SM-1.0.144.1.2-20190705090342.x86_64.rpm"
#export WEBMONG="WebMonG_JAVAatHP-2.1.0.61.0.0.1-20181204102949.i386.tar.gz"

yum update -y
yum install -y python3
yum install -y curl
##ksh is needed for installation of WebMonG
yum install -y ksh
yum install -y sshpass
yum install -y vim
yum install -y firefox
yum install -y gcc
yum install -y kernel sources
yum install -y kernel-devel
yum install -y net-tools
yum install -y telnet
yum install -y epel-release
rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
yum install -y alien


python3 -m pip -V
if [ $? -eq 0 ]
    then
	    echo -e "\e[00;32m#################################\e[00m"
        echo -e "\e[00;32m Pip is installed\e[00m"
        echo -e "\e[00;32m#################################\e[00m"
	else
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --user
fi

###Ansible installation:

python3 -m pip install --user ansible-core==2.8
ansible --version
python3 -m pip show ansible



command -v docker >/dev/null 2>&1
if [ $? -eq 0 ]
    then
	    echo -e "\e[00;32m#################################\e[00m"
        echo -e "\e[00;32m Docker is installed\e[00m"
        echo -e "\e[00;32m#################################\e[00m"
	else
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
#rpm --import https://get.docker.com/gpg
#rpm --import https://download.docker.com/linux/centos/gpg
sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin
#sudo usermod -a -G docker vagrant
sudo systemctl enable docker
sudo systemctl start docker

fi

##Preparation for clean docker-compose installation
rm -f /usr/local/bin/docker-compose
rm -f /usr/bin/docker-compose
if [ ! -f /usr/local/bin/docker-compose ]
 then
  curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
 else
  echo "Docker-compose is already installed on the system"
fi

yum install -y git
/bin/su - vagrant -c "git config --global user.name "Kristiyan Zdravkov""
/bin/su - vagrant -c "git config --global user.email kristian.zdravkov@gmail.com"




#rpm -qa |grep EIS
#if [ $? -eq 0 ]
#    then
#	    echo -e "\e[00;32m#################################\e[00m"
#        echo -e "\e[00;32m EisTools is installed\e[00m"
#        echo -e "\e[00;32m#################################\e[00m"
#	else
#rpm -ivh /vagrant/packages/$EIS
#fi

if [ -d "${AUTO}" ]
 then
	    echo -e "\e[00;32m#################################\e[00m"
        echo -e "\e[00;32m The main directory $AUTO is created\e[00m"
        echo -e "\e[00;32m#################################\e[00m" 
 else
    mkdir /$AUTO
fi
#Removing it due to unnecessary functionality
#cd $AUTO ; tar xzf /vagrant/packages/$WEBMONG
chown -R vagrant: $AUTO

###if [ -d /opt/WebMonG/bin ]
###    then
###	    echo -e "\e[00;32m#################################\e[00m"
###        echo -e "\e[00;32m WebMonG is installed\e[00m"
###        echo -e "\e[00;32m#################################\e[00m"
###	 else
###	 #need auto confirmation "y" implementation for installing the WebMonG package
###	 cd $AUTO/WebMonG_JAVAatHP-2.1.0.61.0.0.1/package ; ./INSTALL_manually.sh
###fi

##Copy the necessary files into the servers folder $AUTO

#if [ -f $AUTO/$EIS ]
#   then
#    	echo -e "\e[00;32m#################################\e[00m"
#        echo -e "\e[00;32m $EIS exists in $AUTO\e[00m"
#        echo -e "\e[00;32m#################################\e[00m"
#   else
#        cp /vagrant/packages/$EIS $AUTO
#fi


#if [ -f $AUTO/$WEBMONG ]
#   then
#    	echo -e "\e[00;32m#################################\e[00m"
#        echo -e "\e[00;32m $WEBMONG exists in $AUTO\e[00m"
#        echo -e "\e[00;32m#################################\e[00m"
#   else
#        cp /vagrant/packages/$WEBMONG $AUTO
#fi

chown -R vagrant: $AUTO

#Creating ssh key for ansible execution
#/bin/su - vagrant -c "echo -e \"\\n\"|ssh-keygen -q -t rsa -N ''"
