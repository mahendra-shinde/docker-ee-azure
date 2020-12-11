USERNAME=$1
FQDN=$3
ADMINPASS=$2

echo "10.0.0.4 master" | tee -a /etc/hosts
echo "10.0.1.10 node-1" | tee -a /etc/hosts
echo "10.0.1.11 node-2" | tee -a /etc/hosts

export DEBIAN_FRONTEND=noninteractive
wget -q -O - https://repos.mirantis.com/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://repos.mirantis.com/ubuntu  $(lsb_release -cs)  stable"
apt update -y
apt install docker-ee docker-ee-cli -y
usermod -aG docker $USERNAME

hostname=$(hostname)
if [ $hostname == 'master' ]
then

echo "This is MASTER node, Installing the UCP"
 
docker image pull mirantis/ucp:3.3.2

docker container run --rm -it --name ucp  -v /var/run/docker.sock:/var/run/docker.sock mirantis/ucp:3.3.2 install --host-address 10.0.0.4 --san=$FQDN --admin-password=$ADMINPASS --admin-username=$USERNAME" 

else
 echo "This is WORKER node"
fi
