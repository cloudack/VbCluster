#!/bin/bash         
sudo su
yum clean all
yum update
yum -y install java-1.7.0-openjdk.x86_64
mkdir /data
mkdir /data/nn
mkdir /data/dd
chown -R vagrant:vagrant /data/nn
chown -R vagrant:vagrant /data/dd
service iptables stop
chkconfig iptables off
sudo su - vagrant
cp /etc/share/vm/hadoop.tar /home/vagrant/
tar -xvf /home/vagrant/hadoop.tar
chown vagrant:vagrant /home/vagrant/hadoop.tar
chown -R vagrant:vagrant /home/vagrant/hadoop-0.20.2-cdh3u6/
cp /etc/share/vm/hosts /etc/
cp -r /etc/share/vm/*.xml  /home/vagrant/hadoop-0.20.2-cdh3u6/conf/
jdk_home=$(dirname $(dirname $(readlink -f $(which java))))
echo 'export JAVA_HOME='$jdk_home > /home/vagrant/hadoop-0.20.2-cdh3u6/conf/hadoop-env.sh
echo 'export PATH=$PATH:/home/vagrant/hadoop-0.20.2-cdh3u6/bin' > /home/vagrant/.bashrc
sudo su - vagrant -c '/home/vagrant/hadoop-0.20.2-cdh3u6/bin/hadoop namenode -format'
sudo su - vagrant -c '/home/vagrant/hadoop-0.20.2-cdh3u6/bin/hadoop-daemon.sh start namenode'
sudo su - vagrant -c '/home/vagrant/hadoop-0.20.2-cdh3u6/bin/hadoop-daemon.sh start jobtracker'
