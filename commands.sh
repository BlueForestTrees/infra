#initialiser une machine
apt update
apt upgrade
adduser pi
sudo groupadd docker
sudo usermod -aG sudo pi
sudo usermod -aG docker pi
#docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install docker-ce

#démarrer rancher
docker run -d --restart=unless-stopped -p 80:80 -p 443:443 -v /var/lib/rancher:/var/lib/rancher --name=rancher-server rancher/rancher --acme-domain rancher.blueforest.org

docker images prune #supprime les images non utilisées ??
docker rm -f $(docker ps -a -q) #supprimer tous les containers
docker rmi $(docker images -q) #supprimer toutes les images



#connection string mongo
#mongodb://admin:7Rlititi@mongodb-replicaset.mongodb-replicaset.svc.cluster.local:27017/BlueForestTrees?replicaSet=rs0&authSource=admin
