sudo yum -y install java-1.8.0-openjdk
sudo yum -y install wget
wget http://mirrors.estointernet.in/apache/kafka/2.3.1/kafka_2.11-2.3.1.tgz
tar -xzf kafka_2.11-2.3.1.tgz
export PATH="$PATH:$HOME/bin:$HOME/kafka_2.11-2.3.1/bin"
source ~/.bash_profile