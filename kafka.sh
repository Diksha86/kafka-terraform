sudo yum -y install java-1.8.0-openjdk
sudo yum -y install wget
wget http://mirrors.estointernet.in/apache/kafka/2.3.1/kafka_2.11-2.3.1.tgz
tar -xzf kafka_2.11-2.3.1.tgz
sudo sed -i 's!'$HOME/bin'!'$HOME/bin:$HOME/kafka_2.11-2.3.1/bin'!' .bash_profile
source .bash_profile
cat /etc/rc.d/rc.local << EOF 
/root/kafka_2.12-2.0.0/bin/zookeeper-server-start.sh /root/kafka_2.12-2.0.0/config/zookeeper.properties > /dev/null 2>&1 &
EOF
sudo chmod +x /etc/rc.d/rc.local
sudo systemctl enable rc-local
sudo systemctl start rc-local
